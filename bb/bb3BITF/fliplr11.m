% z=FLIPLR11(x,para) flip row vector elements left right such as [ 1 2 3 4] --> [4 3 2 1]
% SHAPE: row vector, cln vector will work(contrary to Matlab)
% tested: minimal
% %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z=fliplr11(x)
 IMPLM=11;
 if IMPLM == 1
    z= fliplr(x);     
 end; 
 if IMPLM == 11
    z= x(end:-1:1);     
 end;
end 

