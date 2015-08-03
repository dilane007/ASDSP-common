function z = ul2l(x) 

%implement1
% s= ul2hex(x);
% z= hex2l(s);

%implement2
%    error(nargchk(1, 1, nargin));
%    x = x(:);
%    if ~isreal(x)
%       error('Input must be real.');
%    end
%    x = uint32(x);
%    s = sprintf('%.8x', double(x));
%    s = reshape(s, [8, length(x)]).';
% 
% % z= hex2l(s);
%    hs = size(s);
%    % Convert to the output data type.
%    n = uint32(reshape(sscanf(s, '%1x'), hs));
%    m = uint32(n(:,1));
%    m = bitor(bitshift(m, 4), n(:,2));
%    m = bitor(bitshift(m, 4), n(:,3));
%    m = bitor(bitshift(m, 4), n(:,4));
%    m = bitor(bitshift(m, 4), n(:,5));
%    m = bitor(bitshift(m, 4), n(:,6));
%    m = bitor(bitshift(m, 4), n(:,7));
%    m = bitor(bitshift(m, 4), n(:,8));
% 
%    i = n(:,1) >= 8;
%    z = int32(m);
%    z(i) = double(m(i)) - 4294967296;
% 
% 
%implement3
   x = x(:);
   x = uint32(x);
   s = sprintf('%.8x', double(x));
   s = reshape(s, [8, length(x)]).';

   % Convert to the output data type.
   n = uint32(reshape(sscanf(s, '%1x'), size(s)));
   m = uint32(n(:,1));
   m = bitor(bitshift(m, 4), n(:,2));
   m = bitor(bitshift(m, 4), n(:,3));
   m = bitor(bitshift(m, 4), n(:,4));
   m = bitor(bitshift(m, 4), n(:,5));
   m = bitor(bitshift(m, 4), n(:,6));
   m = bitor(bitshift(m, 4), n(:,7));
   m = bitor(bitshift(m, 4), n(:,8));

   i = n(:,1) >= 8;
   z = int32(m);
   z(i) = double(m(i)) - 4294967296;



