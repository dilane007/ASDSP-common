% bitshifta.m
%=======================================================
function  ulZ = bitshifta(ulX,lK)
    ulV=bitshift(ulX,lK);
    signed = eq(bitshift(ulX,-31),1);
    if (signed) %do sign extend
        %first create mask
        ulM= uint32(hex2dec('FFFFFFFF'));
        ulM= bitshift(ulM,lK);
        ulM= bitcmp(ulM);
        %then apply
        ulZ=bitor(ulV,ulM);
    else%keep as zero ext
        ulZ=ulV;
    end;

   
   