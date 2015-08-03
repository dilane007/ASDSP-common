function z = l2ul(x) 

%implement1
% s= l2hex(x);
% z= hex2ul(s);
% end

% %implement2
%   % check number of input arguments
%    error(nargchk(1, 1, nargin));
% 
%    x = x(:);
%    if ~isreal(x)
%       error('Input must be real.');
%    end
% 
%    x = int32(x);
%    k = x < 0;
%    x = double(x);
%    x(k) = x(k) + 4294967296;
%    s = sprintf('%.8x', x);
%    s = reshape(s, [8, length(x)]).';
% 
% % z= hex2ul(s);
%    hs = size(s);
%    % Convert to the output data type.
%    n = uint32(reshape(sscanf(s, '%1x'), hs));
%    z = uint32(n(:,1));
%    for i = 2:8
%       z = bitor(bitshift(z, 4), n(:,i));
%    end

%implement3
   x = x(:);
   x = int32(x);
   k = x < 0;
   x = double(x);
   x(k) = x(k) + 4294967296;
   s = sprintf('%.8x', x);
   s = reshape(s, [8, length(x)]).';

   % Convert to the output data type.
   n = uint32(reshape(sscanf(s, '%1x'), size(s)));
   z = uint32(n(:,1));
   for i = 2:8
      z = bitor(bitshift(z, 4), n(:,i));
   end



