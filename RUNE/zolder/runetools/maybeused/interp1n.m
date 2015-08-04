function yi = interp1n(x,y,xi)
% function yi = interp1n(x,y,xi) extension of interp1
% interpolating along first dimension
% x and y must span first dimension
% x must be increasing or decreasing in first dimension
% xi can be of any dimension
% yi may be complex but x and xi must be real
% x, y and xi are aligned to match each other
% in all dinensions but the first
% yi  will have the expanded size of the input arguments
% Try interp1n([1;2],[1;2],0)
% Try interp1n(-cumsum(rand(3,2,1)),rand(3,1,2),rand(4,2,2)) 

% by Magnus Almgren 001006

if isempty(xi) % empty in, empty out
 yi = xi;
 break
end

% check that x is increasing
d = diff(x,[],1)<0; % 1 if decreasing
if any(d(:))
 if all(d(:)) % if decreasing then flip x and y
  x = flipdim(x,1); 
  y = flipdim(y,1);
 else
  error('first argument must be monotonic')
 end  
end
fs = firstsing(x,y,xi); % first not used dimension
xi = swdims(xi,[1,fs]); % make sure that xi do not disturb

% now the serious stuff
[xxy, yxy] = adjsiza(x,y); 
ind = vsort1n(xi,xxy);

indx = index1(min(size(xxy,1)-1,ind),1,size(xxy));
if size(xxy,1)==1
 % a rather odd case when size(x,1) == 1 thus
 % making up a rather short table
 indx = ones(size(indx));
 x0  = adjsiza(xi,indx);
 xi1 = xxy(indx);
 xi2 = xxy(indx)+1; % avoid div by zero
 yi1 = yxy(indx);
 yi2 = yxy(indx);
else % the normal case
 % prepare needed values for interpolation
 x0  = adjsiza(xi,indx);
 xi1 = xxy(indx);
 xi2 = xxy(indx+1);
 yi1 = yxy(indx);
 yi2 = yxy(indx+1);
end

if ndimsm(xxy)==1 % only first dimension used? 
 % in this case matlab may form a matrix of a size
 % that is different from indx
 xi1 = reshape(xi1,size(x0));
 xi2 = reshape(xi2,size(x0));
 yi1 = reshape(yi1,size(x0));
 yi2 = reshape(yi2,size(x0));
end 
 
% interpolate and avoid divide by zero problems (mdiv) 
yi = mdiv(yi1.*(xi2-x0) + yi2.*(x0-xi1),xi2-xi1);

yi = swdims(yi,[1,fs]); % switch back first dimension
