/////////////////////////////////////////////////////////////////////
//
//  strrangesubs_cimp.cpp
//
//  The C/C++ implementation of strrangesubs.m
//
//  Created by Dahua Lin, on Jun 26, 2007
//
/////////////////////////////////////////////////////////////////////

#include "mex.h"

struct Range
{
    int start;
    int last;
    
    int length() const
    {
        return last - start + 1;
    }
};

struct RefString
{
    const mxChar* data;
    int length;
    
    RefString()
    {
        data = 0;
        length = 0;
    }
    
    void set_from(const mxArray* mxStr)
    {
        if (!mxIsEmpty(mxStr))
        {
            if (!mxIsChar(mxStr))
            {
                mexErrMsgIdAndTxt("dmtoolbox:strrangesubs:invalidarg", 
                    "The strings to substitute should be either empty or a string");
            }
            data = (const mxChar*)mxGetData(mxStr);
            length = mxGetNumberOfElements(mxStr);
        }
        else
        {
            data = 0;
            length = 0;
        }        
    }
};


inline mxChar* append_substring(mxChar* target, const mxChar* src, int start, int last)
{
    for(int i = start-1; i < last; ++i)
    {
       *(target++) = src[i]; 
    }
    return target;
}

inline mxChar* append_refstring(mxChar* target, const RefString& rstr)
{    
    return append_substring(target, rstr.data, 1, rstr.length);
}


RefString* create_refstrings(const mxArray* mxSubs, int nr, bool& fixed)
{       
    RefString* rstrs = 0;
    if (mxIsCell(mxSubs))
    {
        fixed = false;
        if (mxGetNumberOfElements(mxSubs) != nr)
        {
            mexErrMsgIdAndTxt("dmtoolbox:strrangesubs:sizemismatch", 
                "The number of strings in subs does not equal the number of ranges.");
        }
    
        rstrs = (RefString*)mxMalloc(sizeof(RefString) * nr);
        for (int i = 0; i < nr; ++i)
        {
            rstrs[i].set_from(mxGetCell(mxSubs, i));
        }
    }
    else if (mxIsChar(mxSubs))
    {
        fixed = true;
        rstrs = (RefString*)mxMalloc(sizeof(RefString));
        rstrs->set_from(mxSubs);
    }
    else
    {
        if (!mxIsCell(mxSubs))
        {
            mexErrMsgIdAndTxt("dmtoolbox:strrangesubs:invalidarg",
                "mxSubs should be a cell array of strings.");
        } 
    }
        
    return rstrs;
}

void free_refstrings(RefString* rstrs)
{
    mxFree(rstrs);
}


void fill_by_replace(const mxChar* source, int len0, mxChar* target, 
                     int nr, const Range* ranges, const RefString* rstrs, bool fixed)
{
    int last_src_pos = 0;
    
    for (int i = 0; i < nr; ++i)
    {
        target = append_substring(target, source, last_src_pos+1, ranges[i].start-1);    
        if (!fixed)
        {
            target = append_refstring(target, rstrs[i]);
        }
        else
        {
            target = append_refstring(target, *rstrs);
        }
                
        last_src_pos = ranges[i].last;
    }
    
    if (last_src_pos < len0)
    {
        target = append_substring(target, source, last_src_pos+1, len0); 
    }       
}

const Range* get_ranges(const mxArray* mxRgns, int& nr)
{
    if (!mxIsEmpty(mxRgns))
    {
        if (mxIsInt32(mxRgns) && mxGetNumberOfDimensions(mxRgns) == 2)
        {
            int m = mxGetM(mxRgns);
            int n = mxGetN(mxRgns);
            
            if (m == 2)
            {
                nr = n;
                return (const Range*)mxGetData(mxRgns);
            }
            else if (m == 1 && !(n % 0x01))
            {
                nr = n >> 1;
                return (const Range*)mxGetData(mxRgns);
            }          
        }
        
        mexErrMsgIdAndTxt("dmtoolbox:strrangesubs:invalidarg", 
            "The ranges are in illegal form");
        
        return 0;
    }
    else
    {
        nr = 0;
        return 0;
    }
}

void check_ranges(const Range* ranges, int nr, int len0)
{
    int lb = 0;
    for (int i = 0; i < nr; ++i)
    {        
        const Range& crgn = ranges[i];
        if (crgn.start <= lb || crgn.last < crgn.start-1 || crgn.last > len0)
        {
            mexErrMsgIdAndTxt("dmtoolbox:strrangesubs:illegalrange",
                "The indices of the ranges are illegal for the specified source");
        }
        lb = crgn.last;
    }
}

int compute_new_len(int len0, int nr, const Range* ranges, const RefString* rstrs, bool fixed)
{
    int new_len = len0;
    if (!fixed)
    {
        for (int i = 0; i < nr; ++i)
        {
            new_len += (rstrs[i].length - ranges[i].length());
        }
    }
    else
    {
        for (int i = 0; i < nr; ++i)
        {
            new_len += (rstrs->length - ranges[i].length());
        }
    }
    
    return new_len;
}


mxArray* do_subs(const mxArray* mxStr, const mxArray* mxRgns, const mxArray* mxSubs)
{
    // take arguments
    
    // source string
    const mxChar* src = (const mxChar*)mxGetData(mxStr);
    int len0 = mxGetNumberOfElements(mxStr);
    
    // ranges
    int nr = 0;
    const Range* ranges = get_ranges(mxRgns, nr);
    if (nr == 0)
    {
        return const_cast<mxArray*>(mxStr);
    }    
    check_ranges(ranges, nr, len0);
           
    // subs
    bool fixed = true;
    RefString* rstrs = create_refstrings(mxSubs, nr, fixed);
    
    int new_len = compute_new_len(len0, nr, ranges, rstrs, fixed);
       
    mwSize dims[2] = {1, new_len};
    mxArray* mxStrNew = mxCreateCharArray(2, dims);
    mxChar* target = (mxChar*)mxGetData(mxStrNew);
    
    fill_by_replace(src, len0, target, nr, ranges, rstrs, fixed);
    
    free_refstrings(rstrs);
    
    return mxStrNew;
}



/**
 * main entry
 * Inputs
 *   - str:     the source string
 *   - ranges:  the ranges array
 *   - subs:    the cell array of substitute string
 * Outputs
 *   - sstr:    the new string
 */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    // take arguments
    const mxArray* mxStr = prhs[0];
    const mxArray* mxRgns = prhs[1];
    const mxArray* mxSubs = prhs[2];
    
    plhs[0] = do_subs(mxStr, mxRgns, mxSubs);
    
}


