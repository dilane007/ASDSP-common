/////////////////////////////////////////////////////////////////////
//
//  strsplit_core.cpp
// 
//  The C/C++ implementation of the core part of strsplit:
//  given the ranges of delimiters, return the delimited substrings
//
//  Since the validity of input is guaranteed by strsplit.m, 
//  in the C/C++ implementation, the unnecessary checking is not
//  carried out.
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
    
    void set(int p0, int p1) 
    {
        start = p0;
        last = p1;
    }
    
    bool isempty() const
    {
        return start > last;
    }
};

const Range* get_ranges(const mxArray* mxRgns, int& nr)
{
    nr = mxGetN(mxRgns);
    return (const Range*)mxGetData(mxRgns);
}


/** 
 * determine ranges of parts according to that of delimiters
 */
void part_ranges(int len0, const Range* delim_rgns, int nd, Range* part_rgns, int& np)
{    
    const Range* pdrgn = delim_rgns;
    int ip = 0;
   
    // the part before first delimiter
    if (pdrgn->start > 1)
    {
        part_rgns[ip++].set(1, pdrgn->start-1);
    }
   
    // the middle parts
    for(int id = 0; id < nd-1; ++id)
    {
        int sp = pdrgn->last+1;
        int lp = (++pdrgn)->start-1;
        part_rgns[ip++].set(sp, lp);
    }
    
    // the part after last delimiter
    if (pdrgn->last < len0)
    {
        part_rgns[ip++].set(pdrgn->last+1, len0);
    }
        
    np = ip;
}


mxArray* make_substring(const mxChar* src, const Range& rgn)
{
    if (rgn.isempty())
    {
        mwSize z[2] = {0, 0};
        return mxCreateCharArray(2, z);
    }
    
    mwSize dims[2] = {1, rgn.length()};
    mxArray* mxS = mxCreateCharArray(2, dims);    
    
    mxChar* dst = (mxChar*)mxGetData(mxS);
    for(int i = rgn.start-1; i < rgn.last; ++i)
    {
        *dst++ = src[i];
    }
    
    return mxS;    
}


mxArray* make_multi_substrings(const mxChar* src, const Range* rgns, int nr)
{
    if (nr > 0)
    {
        mxArray* mxC = mxCreateCellMatrix(1, nr);
        
        for (int i = 0; i < nr; ++i)
        {
            mxSetCell(mxC, i, make_substring(src, rgns[i]));
        }
        
        return mxC;
    }
    else
    {
        return mxCreateCellMatrix(0, 0);
    }
}


/**
 * main entry:
 * Inputs
 *  - str:          the source string
 *  - dranges:      the ranges of delimiters
 * Outputs
 *  - C:            the cell array of delimited sub strings
 */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    const mxArray* mxStr = prhs[0];
    const mxArray* mxDRgns = prhs[1];
    
    if (!mxIsChar(mxStr))
    {
        mexErrMsgIdAndTxt("dmtoolbox:strsplit:invalidarg", "str should be a string");
    }
    const mxChar* src = (const mxChar*)mxGetData(mxStr);
    int len0 = mxGetNumberOfElements(mxStr);
    
    int nd = 0;
    const Range* dranges = get_ranges(mxDRgns, nd);
    
    Range* ranges = new Range[nd+1];
    int np = 0;
    part_ranges(len0, dranges, nd, ranges, np);
    
    mxArray* mxC = make_multi_substrings(src, ranges, np);
    
    plhs[0] = mxC;
}




