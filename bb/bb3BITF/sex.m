function z= sex(x,NN)
% sign extend to a width of NN bits

%% Input pins: format change and range checking if needed
% big empty

%% Kernel
switch(NN)
    case(8), z = int8(x);
    case(16),z = int16(x);
    case(24),z = int32(x);
    case(32),z = int32(x);
    case(40),z = int64(x);
    case(48),z = int64(x);
    case(64),z = int64(x);
    otherwise, error('undefined width in zero extension');
end 