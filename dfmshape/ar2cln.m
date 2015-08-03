%z= ar2cln(x,{1,2})  Return elements of an array as a cln vector.
% z= ar2cln(x)   returns a cln in cln major
% z= ar2cln(x,1) returns a cln in cln major
% z= ar2cln(x,2) returns a cln in row major
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = ar2cln(x, major)
   if nargin<2, major=1; end;
   if major ==1
      z = reshape(x,[],1);
   elseif major==2
      z = reshape(x.',[],1);
   else disp('error; major =1 or 2');
   end;
end