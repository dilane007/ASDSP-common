/////////////////////////////////////////////////////////////////////
//
//  strranges_cimp.cpp
//
//  The C/C++ implementation of strranges.m
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
    
    bool valid_for(int len) const
    {
        return start > 0 && last >= start && last <= len;
    }
};

int range_num(const mxArray *mxRgns)
{
    if (mxIsInt32(mxRgns) && mxGetNumberOfDimensions(mxRgns) == 2)
    {
        int m = mxGetM(mxRgns);
        int n = mxGetN(mxRgns);
        
        if (m == 1 && !(n & 0x01)) return n >> 1;
        else if (m == 2) return n;        
    }
    
    mexErrMsgIdAndTxt("dmtoolbox:strranges:invalidrange", 
            "Invalid form of ranges");    
    return 0;
}

void check_ranges(const Range* ranges, int nr, int len0)
{
    for (int i = 0; i < nr; ++i)
    {               
        if (!ranges[i].valid_for(len0))
        {
            mexErrMsgIdAndTxt("dmtoolbox:strranges:outbound", 
                "The ranges are out of boundary");
        }
    }
}

mxArray* extract_string(const mxChar* src, const Range& rgn)
{
    mwSize dims[2] = {1, rgn.length()};
    
    mxArray* mxS = mxCreateCharArray(2, dims);
    mxChar* dst = (mxChar*)mxGetData(mxS);
    
    for (int i = rgn.start-1; i < rgn.last; ++i)
    {
        *dst++ = src[i];
    }
    
    return mxS;
}


/**
 * main entry:
 * - Inputs:
 *   - str:   the source string (char)
 *   - rgns:  the ranges (int32 or empty)
 * - Outputs:
 *   - C:     the cell array of sub strings
 */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    if (nrhs != 2)
    {
        mexErrMsgTxt("The number of input arguments of strranges should be 2.");
    }
    
    const mxArray* mxStr = prhs[0];
    const mxArray* mxRgns = prhs[1];
    
    if (!mxIsChar(mxStr))
    {
        mexErrMsgIdAndTxt("dmtoolbox:strranges:invalidarg", 
            "str should be a string");
    }
    
    // check ranges
    int nr = range_num(mxRgns);
    if (nr > 0)
    {
        int len0 = mxGetNumberOfElements(mxStr);
        
        const Range* ranges = (const Range*)mxGetData(mxRgns);
        check_ranges(ranges, nr, len0);
        
        // extract strings
        const mxChar* src = (const mxChar*)mxGetData(mxStr);
        mxArray* mxC = mxCreateCellMatrix(1, nr);
        
        for (int i = 0; i < nr; ++i)
        {
            mxSetCell(mxC, i, extract_string(src, ranges[i]));
        }        
        
        // make output
        plhs[0] = mxC;
    }
    else
    {
        plhs[0] = mxCreateCellMatrix(0, 0);
    }    
    
}



