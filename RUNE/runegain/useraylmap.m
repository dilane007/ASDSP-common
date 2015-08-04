function rayl = useraylmap(pos, raylmap, raylmapvec, dim)
% DESCRIPTION
%  rayl = useraylmap(pos, raylmap, raylmapvec, dim)
%  Calculates rayleigh fading for number of positions (mobiles). If more than one
%  map was created when the rayleigh fading was generated there will be multiple
%  rayleigh values for each position.
%  
% INPUT
%  pos --        Any complex matrix containing positions which may be interpreted as
%                absolute or relative positions in 2 dimensions.
%                Any position is valid since wrapping into the map is performed.
%                
%  raylmap--     The body of samples within wich interpolation will be performed
%                May consist of more than one map in which case the will be stored in 
%                third dimension. In this case the output is a cell array
%  raylmapvec -- Two complex vectors spanning the area of the map. The size of the first
%                dimension is the same as the size of the map in first and
%                second dimension. 
%  dim --        The dimension in which interpolated samples from the third dimension of the
%                maps are stored. Default is the first singleton dimension of
%                pos.
% OUTPUT
%  rayl --       matrix of the same size as pos when raylmap doesn't
%                make use of the third dimension.
%                The values are complex and their amplitudes are rayleigh
%                distributed. The standard deviation of the complex amplitude output rayl is 1.
%                If raylmap makes use of the third dimension there are more than one
%                map sample for each input position.
%                In that case these samples are collected in dimension dim. This 
%                dimension is default selected as the fist singleton dimension of pos               
% SEE ALSO  
%  creraylmap
% TRY
%  useraylmap; % generates a plot
%  [raylmap, mapvec] = creraylmap([1 i]*200);
%  plot(lin2db(abs(useraylmap(linspace(0,irandn,1000),raylmap,mapvec))))
%  mean(abs(useraylmap((0:0.01:100)*irand,raylmap,mapvec).^2))

% by Magnus Almgren 031116

if nargin == 0 % one meter travel in random direction
pos = 0;
end

if isempty(pos) % empty in empty out
 rayl = pos;
 return
end

if size(raylmapvec(:),1)<=1 % mo map => no fading
 rayl = ones(size(pos)); 
 return
end

if nargin < 3 % create a map if it wasn't present
 [raylmap, raylmapvec] = creraylmap;
end


if nargin == 0 % one meter travel in random direction
 pos = (1:1000)'/1000*raylmapvec(end,1)+eps;
end

% There might be more than one map sample for each input position.
% In that case these samples are collected in dimension dim. This 
% dimension is default selected as the fist singleton dimension of pos
% Better is to specify that dimension as an input.
if ~exist('dim','var')
 dim = firstsing(pos); % first non occupied dimension of pos
else
 siz =size(dim);
 if siz(dim)>1
  error('Dimension dim is already in use by pos')
 end
end
rv = raylmapvec(end,:);
wpos = wrapinto(pos,rv,'rhomb');

% the inverse base of rv (rv(1)*base => [1 0] and rv(2)*base => [0 1] 
invbase = inv([real(rv.') imag(rv.')]);

% the portions of v(1) and v(2) for each position element
spos = mprod([real(wpos(:)) imag(wpos(:))]*invbase,abs(raylmapvec(end,:)));

% wrap it  back into the interval {0,abs(rv)}
% shift out 3 dimensions to free space for interpolation

pos1 = shiftdim(reshape(spos(:,1), size(pos)),-3);
pos2 = shiftdim(reshape(spos(:,2), size(pos)),-3);

% vectors used by interp2 for table lookup 
siz = size(raylmap,1)-1;
mapi = abs(raylmapvec);

% make position interpolation
rayl = [];

for j = 1:size(raylmap,3)  % store linear complex samples
 raylj = interp2(mapi(:,1), mapi(:,2), raylmap(:,:,j).', pos1, pos2);
 rayl = cat(dim+3,rayl, raylj); 
end

% shift back 3 dimensions to get to the dimensions of the inputs
rayl = shiftdim(rayl,3);

if nargin == 0 % one meter travel in random direction
  % contour(lin2db(abs(raylmap)*2));
  % hist(pos(:))
  plot(rayl,'.-')
  ploth([rayl(end);rayl(1)],'r.-')
end

% $Id: useraylmap.m,v 1.2 2004/03/11 15:01:31 olav Exp $
