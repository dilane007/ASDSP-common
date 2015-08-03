function z= cxeye(varargin)
% just another name for ieye    
% DESCRIPTION z= ieye(r,c,...)  
%  Complex Identity matrix
% Syntax
%  Y = ieye(n)
%  Y = ieye(m,n)ieye([m n])
%  Y = ieye(size(A)) 
%  ieye(m, n, classname) 
%  ieye([m,n],classname)
% Description
%  Y = ieye(n) returns the n-by-n identity matrix.
%  Y = ieye(m,n) or ieye([m n]) returns an m-by-n matrix with 1's on the diagonal and 0's elsewhere.   
%  Y = ieye(size(A)) returns an identity matrix the same size as A.
%  ieye(m, n, classname) or ieye([m,n],classname) returns an m-by-n matrix with 1's of class classname on the diagonal and zeros of class classname elsewhere. 
%    classname: 'double', 'single', 'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64', 'uint64'.
%    Example: z = eye(2,3,'int8');
% Limitations
%   The identity matrix is not defined for higher-dimensional arrays. The assignment y = ieye([2,3,4]) results in an error.
% See Also: ones, rand, randn, zeros, eye
z = eye(varargin{:}) + i*eye(varargin{:});

