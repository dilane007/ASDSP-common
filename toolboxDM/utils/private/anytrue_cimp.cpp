/////////////////////////////////////////////////////////////////////
//
//  anytrue_cimp.cpp
//
//  The C/C++ implementation of anytrue.m
//
//  Created by Dahua Lin, on Jun 27, 2007
//
/////////////////////////////////////////////////////////////////////

#include "mex.h"


mxArray* test_any_true(const mxArray *mxV)
{
    if (mxIsEmpty(mxV))
    {
        return mxCreateLogicalScalar((mxLogical)false);
    }
    
    if (!mxIsLogical(mxV))
    {
        mexErrMsgIdAndTxt("dmtoolbox:anytrue:invalidarg", 
            "The input array to anytrue should be logical or empty");
    }
    
    int n = mxGetNumberOfElements(mxV);
    const mxLogical* values = (const mxLogical*)mxGetData(mxV);
    
    for (int i = 0; i < n; ++i)
    {
        if (values[i]) return mxCreateLogicalScalar((mxLogical)true);
    }
    
    return mxCreateLogicalScalar((mxLogical)false);
}


/**
 * main entry
 * Input
 *  - V:    the logical array
 * Output
 *  - b:    the logical scalar indicating whether there are any true values
 */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    plhs[0] = test_any_true(prhs[0]);
}