/////////////////////////////////////////////////////////////////////
//
//  alltrue_cimp.cpp
//
//  The C/C++ implementation of alltrue.m
//
//  Created by Dahua Lin, on Jun 27, 2007
//
/////////////////////////////////////////////////////////////////////

#include "mex.h"


mxArray* test_all_true(const mxArray *mxV)
{
    if (mxIsEmpty(mxV))
    {
        return mxCreateLogicalScalar((mxLogical)true);
    }
    
    if (!mxIsLogical(mxV))
    {
        mexErrMsgIdAndTxt("dmtoolbox:alltrue:invalidarg", 
            "The input array to alltrue should be logical or empty");
    }
    
    int n = mxGetNumberOfElements(mxV);
    const mxLogical* values = (const mxLogical*)mxGetData(mxV);
    
    for (int i = 0; i < n; ++i)
    {
        if (!values[i]) return mxCreateLogicalScalar((mxLogical)false);
    }
    
    return mxCreateLogicalScalar((mxLogical)true);
}


/**
 * main entry
 * Input
 *  - V:    the logical array
 * Output
 *  - b:    the logical scalar indicating whether all values are true
 */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    plhs[0] = test_all_true(prhs[0]);
}