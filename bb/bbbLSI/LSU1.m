% z= x
%ucode 
%  0  STL
%  1  STS
%  2  STQ
%  3  STB
%  8  LDL
%  9  LDS
%  A  LDSU
%  B  LDQ
%  C  LDB
%  D  LDBU
%endian 
%  0  little
%  1  big
%----------------------------------------------------------
function z = LSU1(x,ucode,endian)
   if (nargin < 3) 
       endian=1;
   end; %default is big

   if (ucode <=4)  
        %unpack 32bit register to 4 bytes
        %numbered   B3_B2_B1_B0
        B0=uint8(bitand(bitshift(x,0),255));       
        B1=uint8(bitand(bitshift(x,-8),255));       
        B2=uint8(bitand(bitshift(x,-16),255));       
        B3=uint8(bitand(bitshift(x,-24),255));       

        outmux=(2*ucode)+endian;
        switch(outmux)
          case(0),        z= [B0 B1 B2 B3];
          case(1),        z= [B3 B2 B1 B0];
          case(2),        z= [B0 B1];
          case(3),        z= [B1 B0];
          case(4),        z= [B2 B3];
          case(5),        z= [B3 B2];
          case{(6),(7)},  z= B0;
        end;    
   else
     if ((ucode >=8) && (ucode <=14))
        inmux=(2*ucode)+endian;
        %pack 4 bytes to 32bit register
        %numbered   B3_B2_B1_B0
        switch(inmux)
            case(16)
                B0 = uint32(x(1));
                B1 = bitshift(uint32(x(2)),8);
                B2 = bitshift(uint32(x(3)),16);
                B3 = bitshift(uint32(x(4)),24);
            case(17)
                B0 = uint32(x(4));
                B1 = bitshift(uint32(x(3)),8);
                B2 = bitshift(uint32(x(2)),16);
                B3 = bitshift(uint32(x(1)),24);
            case(18)
                B0 = uint32(x(1));
                B1 = bitshift(uint32(x(2)),8);
                %sign adding 
                xsign = bitand(B1,hex2dec('00008000'));
                if (xsign==0),  B2 = uint32(0); 
                else            B2 = uint32(hex2dec('FFFF0000')); 
                end;
                B3 = B2;
            case(19)
                B0 = uint32(x(2));
                B1 = bitshift(uint32(x(1)),8);
                %sign adding 
                xsign = bitand(B1,hex2dec('00008000'));
                if (xsign==0),  B2 = uint32(0); 
                else            B2 = uint32(hex2dec('FFFF0000')); 
                end;
                B3 = B2;
            case(20)
                B0 = uint32(0);
                B1 = uint32(0);
                B2 = uint32(x(1));
                B3 = bitshift(uint32(x(2)),8);
            case(21)
                B0 = uint32(0);
                B1 = uint32(0);
                B2 = uint32(x(2));
                B3 = bitshift(uint32(x(1)),8);
            case(22)
                B0 = uint32(0);
                B1 = uint32(0);
                B2 = bitshift(uint32(x(1)),16);
                B3 = bitshift(uint32(x(2)),24);
            case(23)
                B0 = uint32(0);
                B1 = uint32(0);
                B2 = bitshift(uint32(x(2)),16);
                B3 = bitshift(uint32(x(1)),24);
            case{(24),(25)}
                B0 = uint32(x(1));
                %sign adding 
                xsign = bitand(B0,bin2dec('1000 0000'));
                if (xsign==0), B1 = uint32(0);
                else           B1 = uint32(hex2dec('FFFFFF00')); end;  
                B2 = B1;
                B3 = B1;
            case{(26),(27)}
                B0 = uint32(x(1));
                B1 = uint32(0);
                B2 = uint32(0);
                B3 = uint32(0);
        end;
        %pack 
        lV = bitor(B3,B2); 
        lW = bitor(B1,B0); 
        z = bitor(lV,lW); 
           
     end;      
   end;
       
end
