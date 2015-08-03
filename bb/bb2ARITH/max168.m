% z=MAX168(x,y,nlanes) 
%   return the elememt per element max of 2 vectors ;
% SIZE= nlanes = 8(default),4,2
%
function z=max168(x,y,nlanes);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   if nargin < 3, para=8; else para=nlanes; end;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   cc= gt(x,y);
   z= omux21(y,x,cc,para);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

