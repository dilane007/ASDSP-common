% cls.m
% Find the position of the first bit different from MSB bit
% needed to normalize x  
% Input Parameters
%  x= uint32,int32    range: [0..2^32 -1]
%     uint16,int16    range: [0..65535] 
% Output Parameters
%  z= double   range: [0..31]
%--------------------------------------------
function  z = cls(x)
MLABIDX=1;;

is16s = isa(x,'int16');
is16u = isa(x,'uint16');
is32s = isa(x,'int32');
is32u = isa(x,'uint32');

if (is16s), x=s2us(x); end;
if (is32s), x=l2ll(x); end;

cc16 = (is16s) || (is16u);
cc32 = (is32s) || (is32u);
if cc16 
    KK=15; 
else
    KK=31 ; %default;
end; 

   z=0;
   ALLF= power(2,KK+1)-1; %'FFFF' or'FFFFFFFF'
   for kk = KK:-1:2 
        c1 = bitget21(x,kk+MLABIDX);
        c2 = bitget21(x,kk+MLABIDX-1);%next
        if c1 ~= c2,  break; end;
        z=z+1; 
   end
   if (x ==hex2dec('0')) , z=0;end;  %as ITU   
   if (x ==ALLF), z=KK;end;%as ITU    
end   

   
   