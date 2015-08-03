%z= ar2row(x,{1,2})  Return elements of an array as a row vector.
% z= ar2row(x)   returns a row in cln major
% z= ar2row(x,1) returns a row in cln major
% z= ar2row(x,2) returns a row in row major
% derived from Jacklam asrow
%%
function z = ar2row(x, major)
   if nargin<2, major=2; end;
   if major ==2
      z = reshape(x.',1,[]);
   else
      z = reshape(x,1,[]);
   end;
end