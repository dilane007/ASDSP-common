function  y = expfilt(x,alfa,xinit,dim)
% DESCRIPTION  y = expfilt(x,alfa,xinit,dim) first order iir filter
%  preserves amplitude level of input. E[x] = E[y]
%  (E[y.^2]=E[x.^2]*alfa^2 + E[y.^2].*(1-alfa).^2 if independent samples
%  The filtering is performed along dimension dim.
%  of x. x,alfa and xinit are are expanded in all dimension but dim in order
%  to match each others size. If the size of alfa is greater than one along 
%  dimension dim then the filter is non stationary.
%  xinit can be regarded as an earlier last output from the filter.
% INPUTS
%  x     --  target for the filteroperation any complex matrix
%  alfa  --  filter constant. Defaults to 0.1
%  xinit --  target for the filteroperation. Defaults to 0
%  dim   --  dimension in which the filteroperation is performed.
% OUTPUTS
%  y     --  filtered version of x with the combined size of x,alfa and xinit
% SEE ALSO
%  filter
% TRY
%  plot(expfilt(randn(1000,2)))
%  plot(expfilt(ones(30,1),0.2),'.-')

%  by Magnus Almgren 031105

% Empty in empty out 
if isempty(x)
 y = x;
 return
end

% Set defaults
setifnotexist('alfa',0.1);
setifnotexist('xinit',0);
fns = firstnonsing(x,alfa); 
setifnotexist('dim',fns);

% switch filter dimension into first
x     = swdims(x,    [1,dim]);
alfa  = swdims(alfa, [1,dim]);
xinit = swdims(xinit,[1,dim]);
[x,alfa] = adjsiza(x,alfa);
[x,alfa,xinit] = adjsizabdim(1,x,alfa,xinit);

% do the filtering
y = ef(x,alfa,1-alfa,xinit); % do it 

% switch back again
y     = swdims(y    ,[1,dim]);
 
function y = ef(x,alfa,beta,xinit)
% filtering in first dimension
% the first sample.
% Yes this is a for loop!
y(1,:) = alfa(1,:).*x(1,:) + beta(1,:).*xinit(1,:);
for i = 2:size(x,1)
 y(i,:) = alfa(i,:).*x(i,:) + beta(i,:).*y(i-1,:);
end

% shape to original size
y = reshape(y,size(x));
% $Id: expfilt.m,v 1.1 2004/02/19 17:27:42 bogdant Exp $
