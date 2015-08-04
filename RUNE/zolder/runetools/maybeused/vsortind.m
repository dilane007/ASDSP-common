	function indi = vsortind(xi,xv,dim)
% function indi = vsortind(xi,xv,dim)
% xi and xv will be expanded to equal size 
% For each value of xi an index is calculated so that
% the index to the maximum value of xv not exceeds the 
% corresponding value in xi. The output will have at least have
% the same size as xi.
% Make shure that the input argument xv is either increasing decreasing
% along the dimension dim.
% Note that first xv(1,:,:,.. ) has nothing to do with the result
% Try: x = 0:0.1:5; plot(x,vsortind(x, (1:4)'),'*')
% Try: x = 0:0.1:5; plot(x,vsortind(x', [1:4; 3:6]'),'*')
% Try: r= randn(10000,1); plot(r,vsortind(r,linspace(-2,2,7)'),'.')

% by Magnus Almgren 010708
% switch dim into first dimesion and back again

if isempty(xi) % empty in, empty out
 indi = xi;
 break
end


% twist sort dimension into first and something else out to dim
if exist('dim','var') & dim~=1
 xi = swdims(xi,[1 dim]);
 xv = swdims(xv,[1 dim]);
end

if any(diff(xv,[],1)<0)
 if any(diff(xv,[],1)>0)
  error('xv is both increasing and decreasing')
 end
 xv = flipdim(xv,1);
 flipped = 1;
else
 flipped = 0;
end

 % free first dimension
fs = firstsing(xi,xv,ones(2,1)); % block first dimension
xi = swdims(xi,[1 fs]);

sizz = maxsize(xi,xv);
indi = ones([1 sizz(2:end)]);

siz = size(xv,1); 
step = 2.^ceil(log2(siz));  % the initial step size
% find ind such that xv(ind) is just beneath or equal to xi
while step>1
 step =  step/2; % decrease stepsize
 indiprop = index1(min(siz,indi + step),1,size(xv)); 
 xvind = reshape(xv(indiprop),size(indiprop)); % due to the odd syntax of this language
 indi = min(siz,indi + step*(mplus(xi, -xvind)>=0)); % eventually increase ind 
end
indi = swdims(indi,[1 fs]);

% turn index values around to flipped matrix
if flipped 
 indi = indi - size(xv,1) + 1;
end
