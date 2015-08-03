% [DFM] shift by NN bits

function z= bitshift(xin,NN)
%% Input pins: format change and range checking if needed
 x=float(xin);
    
%% Kernel
 switch(NN)
    case {0,1,2,3,4,5,6,7},z = x * (2^NN);
    case {8,9,10,11,12,13,14,15},z = x * (2^(NN));
    case {16,17,18,19,20,21,22,23},z = x * (2^(NN));
    case {24,25,26,27,28,29,30,31},z = x * (2^(NN));
    case {-1,-2,-3,-4,-5,-6,-7},            z = x * (2^NN);
    case {-8,-9,-10,-11,-12,-13,-14,-15},   z = x * (2^NN);
    case {-16,-17,-18,-19,-20,-21,-22,-23}, z = x * (2^NN);
    case {-24,-25,-26,-27,-28,-29,-30,-31}, z = x * (2^NN);
    otherwise, error('NOT a VALID SHIFT VALUE');
 end
        
%% Output pins: format change if needed
 if ( (isa(xin,'uint8')) == 1),      z = uint8(z); end;
 if ( (isa(xin,'uint16')) == 1),     z = uint16(z);end;
 if ( (isa(xin,'uint32')) == 1),     z = uint32(z);end;
%  if ( (isa(xin,'uint64')) == 1),   z = uint64(z);end;

end 

