function  ulZ = bitshifta_ul(ulX,lK)
% type=uint32   io=2+1      shape=unc   modal:modulo
    ulV=bitshift(ulX,lK);
    cc1 = eq(bitshift(ulX,-31),1);%if signed
    cc2 = ne(bitshift(ulX,-31),1);%if unsigned
    %first create mask
    ulM= uint32(hex2dec('FFFFFFFF'));
    ulM= bitshift(ulM,lK);
    ulM= bitcmp(ulM);
    %then apply
    ulZ(cc1)=bitor(ulV(cc1),ulM);
    ulZ(cc2)=ulV(cc2);
end

   
   