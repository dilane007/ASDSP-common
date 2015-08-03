function z= zext(x,NN)
% zero extend to a width of NN bits

%% Input pins: format change and range checking if needed
% big empty

%% Kernel
switch(NN)
    case(8),z = uint8(x);
    case(16),z = uint16(x);
    case(24),z = uint32(x);
    case(32),z = uint32(x);
    case(40),z = uint64(x);
    case(48),z = uint64(x);
    case(64),z = uint64(x);
    otherwise, error('undefined width in zero extension');
        
%% Output pins: format change if needed
% big empty
end 

