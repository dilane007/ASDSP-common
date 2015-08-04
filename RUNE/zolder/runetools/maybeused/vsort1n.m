function res = vsort1n(xv,xi)
% function [ind1] = vsort1n(xv,xi)
% xv and xi will be expanded to equal size 
% For each value of xv an index is calculated so that
% the index to the maximum value of xi not exceeding the 
% corresponding value in xv. The output will have at least have
% the same size as xv.
% Make shure that the input argument xi is increasing or decreasing
% along the first dimension.
% Try: x = 0:0.1:5; plot(x,vsort1n(x, (1:4)'),'*')
% Try: x = 0:0.1:5; plot(x,vsort1n(x', [1:4; 3:6]'),'*')

% note that first xi(1,:,:,.. ) has nothing to do with the result

% by Magnus Almgren 001003

if isempty(xv) % empty in, empty out
 res = xv;
 break
end

% free first dimension
fs = firstsing(xv,xi);
x = swdims(xv,[1 fs]);

sizz = maxsize(x,xi);

siz = size(xi,1); 
ind = ones([1 sizz(2:end)]);
step = 2.^ceil(log2(siz));  % the initial step size
% find ind such that xi(ind) is just beneath or equal to xv
while step>1
 step =  step/2; % decrease stepsize
 indprop = index1(min(siz,ind + step),1,size(xi)); 
 xii = reshape(xi(indprop),size(indprop));
 xgtxi = mplus(x, -xii)>=0;
 ind = min(siz,ind + step*xgtxi); % eventually increase ind 
end
res = swdims(ind,[1 fs]); 