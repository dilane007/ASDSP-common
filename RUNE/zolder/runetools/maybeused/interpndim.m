function zi = interpndim(varargin)
% function zi = interpndim(x1,x2,x3,...,body,xi1,xi2,xi3,...)
% interpolates linearly to find zi, the values of the
% underlying N-D matrix body at the points in matrices x1,x2,...,xn.
% Matrices x1,x2,...,xn specify the points at which the data is given.
% This is much in line with interp2 but extended to
% 1 any number of dimesions
% 2 extrapolates outside xn
% 3 xn can be decreasing
% 4 xin can be of any size and guides the size of zi
% 5 great freedom in dimensions both xn, body and xin
% x1 must span the first dimension since that is where interpolation is performed
% x2 must span the second and so on
% the first  dimension must have the same size in x1 and the body
% the second dimension must have the same size in x2 and the body
% and so on
% the body may have more dimensions than number of interpolation dimensions
% xin can have any size as long as the match each other
% singletons will be expanded to fit the other arguments xi1,xi2,...xin
% zi will receive the "combined" size of xi1,xi2,...,xin  
% TRY interpndim([1;2],[1;2],1) interpndim([1;2],[1 2],[1 2;4 5],[1.1; 2.2],[0.9 1.9]) 
% TRY interpndim([1;2],[1 2],[1 2;4 5],[1.1  2.2],[0.9 1.9]) 
% try interpndim([1;2],[1 2;4 5],2)
% TRY size(interpndim(cumsum(rand(100,1)),cumsum(rand(1,100)),rand(100),100*rand(1,1,40,40),100*rand(1,1,40,40))) 

% by Magnus Almgren 010613

narg = (nargin-1)/2; % number of dimensions to interpolate in
ms = length(maxsize(varargin{narg+1:end})); % max size of args body,xi1,xi2,...
% move away arguments so arguments do not collide
for j = 1:narg
 varargin{narg+1+j}= shiftdim(varargin{narg+1+j},-narg);
end
% move away all dimensions greater than narg dimensions of the body
pvec = [1:narg 2*narg+1:narg+ms narg+1:2*narg];
varargin{narg+1} = ipermute(varargin{narg+1},pvec);

% move back again
zi = shiftdim(interpnn3(varargin{:}),narg);


function zi = interpnn3(varargin)

narg = (nargin-1)/2; % number of dimensions to interpolate in
x = varargin{narg}; % just for clarity
z = varargin{narg+1};
xi = varargin{end};
if size(z,narg)==1
 zi = interpnn3(varargin{1:narg-1},z,varargin{narg+2:end-1});
 break 
end 

ind = min(vsortind(xi,x,narg),size(x,narg)-1); % indeces into x and z 

% Calculate "weights" 
indx1 = index1(ind  ,narg,size(x));
indx2 = index1(ind+1,narg,size(x));
xk1 = xi - reshape(x(indx1),size(indx1));
xk2 = xi - reshape(x(indx2),size(indx1));

% Calculate Z values
indzk1 = index1(ind  ,narg,size(z));
indzk2 = index1(ind+1,narg,size(z));
zk1 = reshape(z(indzk1),size(indzk1));
zk2 = reshape(z(indzk2),size(indzk1));

% interpolate
zi = mdiv(mprod(xk1,zk2) - mprod(xk2,zk1),xk1-xk2); 
if narg ~= 1 % more dimensions to do?
 % recur to the next last dimension
 zi = interpnn3(varargin{1:narg-1},zi,varargin{narg+2:end-1});
end 
