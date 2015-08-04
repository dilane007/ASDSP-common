/////////////////////////////////////////////////////////////////////
//
//  countfalse_cimp.cpp
//
//  The C/C++ implementation of countfalse.m
//
//  Created by Dahua Lin, on Jun 27, 2007
//
/////////////////////////////////////////////////////////////////////

#include "mex.h"


mxArray* count_false(const mxArray* mxV)
{
    if (mxIsEmpty(mxV))
    {
        return mxCreateDoubleScalar(0);
    }
    
    if (!mxIsLogical(mxV))
    {
        mexErrMsgIdAndTxt("dmtoolbox:countfalse:invalidarg", 
            "The input array to countfalse should be logical or empty");
    }
    
    int n = mxGetNumberOfElements(mxV);
    const mxLogical* values = (const mxLogical*)mxGetData(mxV);
    unsigned long c = 0;
    
    for (int i = 0; i < n; ++i)
    {
        if (!values[i]) ++c;
    }
    
    return mxCreateDoubleScalar((double)c);
}


/**
 * main entry
 * Input
 *  - V:    the logical array
 * Output
 *  - c:    the number of true values
 */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    plhs[0] = count_false(prhs[0]);
}