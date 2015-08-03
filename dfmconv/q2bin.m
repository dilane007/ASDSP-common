% Z= Q2BIN
% [bitfield z]= q2bin(x,qpoint)
% x: fp
% qpoint: qpoint syntax is finnicky( ex:8.8 is wrong; use 8.08 instead
%--------------------------------------------------------------------------
function [bitfield z]= q2bin(x,qpoint)
    % (1) x % x is expected to be a fp but in case ..
    fx= double(x);    
    % (2) qpoint: extract integer width and fractional width must always work in flint
    qint= fix(qpoint);
    qfrac= fix(round((qpoint - qint)*100));
    qwidth= qint + qfrac;
    % (3) kernel
    cc= signbit11(fx);
    z= fix(round(fx.* power(2,qfrac)));% fxp --> flint
    maxpos= power(2,qwidth); % 
    zpos= maxpos + z;  %all positive %as int2bin works only on positive value 
    uz(cc==0)=z(cc==0);
    uz(cc==1)=zpos(cc==1);
    bitfield= string(int2bin(uz,qwidth)+'0');
end

% for reference
% function t = dec2bin(x,n)
%   x = x(:); 
%   if (size(x) == [0,0])
%      t = string([]);
%      return;
%   end
%   if (~exist('n') && max(x) > 0) %autocompute the nbr of bits
%     n = ceil(log2(max(x)+1e-10));
%   elseif (~exist('n'))
%     t = string(zeros(size(x))+'0');
%     return;
%   elseif (max(x) == 0)
%     t = string(zeros(size(x))+'0');
%     return;
%   end
%   n= max(1,n);
%   t= string(int2bin(x,n)+'0');
% end