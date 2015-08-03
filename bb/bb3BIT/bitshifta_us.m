function  usZ = bitshifta_us(usX,lK)
% type=uint16   io=2+1      shape=unc   modal:modulo
    usV= bitshift(usX,lK);
    cc1= eq(bitshift(usX,-15),1);%if signed
    cc2= ne(bitshift(usX,-15),1);%if unsigned
    %first create mask
    usM= uint16(hex2dec('FFFF'));
    usM= bitshift(usM,lK);
    usM= bitcmp(usM);
    %then apply
    usZ(cc1)=bitor(usV(cc1),usM);
    usZ(cc2)=usV(cc2);
end

   
   