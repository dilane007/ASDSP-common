% bitshifta_ub4.m
function  unZ = bitshifta_ub4(unX,bK)
 ubV=bitshift(unX,bK);
 %first create mask
 unM= uint8(hex2dec('F'));
 unM= bitshift(unM,bK);
 unM= bitcmp(unM);
 %then apply
 signed   = eq(bitshift(unX,-3),1);
 unsigned = ne(bitshift(unX,-3),1);
 unZ(unsigned)=ubV(unsigned);
 unZ(signed)=bitor(ubV(signed),unM);
end

   
   