%z= row2ar(x,[dim],major)  Return elements of a row vector as an array.
% z= row2ar(x,[3 10],1) returns an array in cln major
% z= row2ar(x,[3 10],2) returns an array in row major
% z= row2ar(x,3)   returns an array of 3 rows organised in row major
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = row2ar(x,dim,major)
   if nargin<3, major=2; end;
   n =dim(1);
   if length(dim)==1,  m=[]; else m=dim(2); end;
   if major ==2,     
       z= reshape(x,m,n);
       z= z.'; 
   else 
       z= reshape(x,n,m);
   end;
 end