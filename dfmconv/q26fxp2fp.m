function fZ = q26q2fp(x)
     % qX= 6bit int__26bit frac;      
     fXt= double(uint8(bitshift(x,-26)));  %00000000 00000000 00000000 00ABCDEF     
     fXq= double(bitand(x,hex2dec('03FFFFFF')));%000000ab cdefghij klmnopqr stuvwxyz       
     fZ= fXt + (fXq/power(2,26)); 
     % now treats singular point
end
