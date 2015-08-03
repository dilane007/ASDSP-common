% function z = clo(x)
% Count Leading Ones 
% Return the number of one bits starting from the msb of the input 
% before the first zero is encountered
% Input Parameters:
%  x= uint32,int32    range: [0..2^32 -1]
%     uint16,int16    range: [0..65535] 
% Output Parameters:
%  z= double   range:[0..31] 
% Use:
% - Huffman decoding
%--------------------------------------------------------
function z = clo(x)
global MLABIDX;

is16s = isa(x,'int16');
is16u = isa(x,'uint16');
is32s = isa(x,'int32');
is32u = isa(x,'uint32');

if (is16s), x=s2us(x); end;
if (is32s), x=l2ll(x); end;

cc16 = (is16s) || (is16u);
cc32 = (is32s) || (is32u);
if cc16 , KK=15; 
else KK=31 ; %default;
end; 

z=0;
for k = KK:-1:0 
    c = bitget(x,k+MLABIDX);
    if c == 0 ,  break;   end;
    z=z+1;
end

