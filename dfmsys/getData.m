function [varargout] = getData(packet, msgId)

switch msgId
    case 131
        varargout{1} = hexsingle2num(dec2hex(swapbytes(uint32(hex2dec(packet(:,1:8))))));
        varargout{2} = hexsingle2num(dec2hex(swapbytes(uint32(hex2dec(packet(:,9:16))))));
    case 156
        varargout{1} = hex2dec(packet(:,1:4));
        varargout{2} = hex2dec(packet(:,5:8));
        varargout{3} = hex2dec(packet(:,9:12));
        varargout{4} = hex2dec(packet(:,13:16));
        
        varargout{1}(varargout{1}>32767) = varargout{1}(varargout{1}>32767) - 65536;
        varargout{2}(varargout{2}>32767) = varargout{2}(varargout{2}>32767) - 65536;
        varargout{3}(varargout{3}>32767) = varargout{3}(varargout{3}>32767) - 65536;
        varargout{4}(varargout{4}>32767) = varargout{4}(varargout{4}>32767) - 65536;
    case 194
        varargout{1} = hexsingle2num(dec2hex(swapbytes(uint32(hex2dec(packet(:,1:8))))));
        varargout{2} = hexsingle2num(dec2hex(swapbytes(uint32(hex2dec(packet(:,9:16))))));
end

