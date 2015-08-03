function  ubZ = bitshifta_ub(ubX,bK)
% type=uint8   io=2+1      shape=unc   modal:modulo
 ubV=bitshift(ubX,bK);
 %first create mask
 ubM= uint8(hex2dec('FF'));
 ubM= bitshift(ubM,bK);
 ubM= bitcmp(ubM);
 %then apply
 cc1= eq(bitshift(ubX,-7),1);%if signed
 cc2= ne(bitshift(ubX,-7),1);%if unsigned
 ubZ(cc1)=bitor(ubV(cc1),ubM);
 ubZ(cc2)=ubV(cc2);
end

   
   