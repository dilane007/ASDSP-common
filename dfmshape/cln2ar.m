%z= cln2ar(x,dim,major)  Return elements of a cln vector as an array.
% z= cln2ar(x,[3 12],1) returns an 3x12 array in cln major
% z= cln2ar(x,6,2) returns an 6 cln array in row major
% z= cln2ar(x,6) returns a 6 cln array !!not 6 rows
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z= cln2ar(x,dim,major)
   if nargin<3, major=1; end;
   n= dim(1);
   if length(dim)==1,  
       n=[]; m=dim(1); 
   else m=dim(2); 
   end;
   z = reshape(x,n,m);
   if major ==1
       z = reshape(x,n,m);
   elseif major==2
       z = reshape(x,m,n);
       z=z.';
   end;
end