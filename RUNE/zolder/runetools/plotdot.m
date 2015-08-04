function res = plotdot(xyp, radius, color, ncorn, ratio);
% DESCRIPTION plotdot(xyp, r, c, ncorn, ratio); 
%  Draws patches with radius 
%  and color. Also the form and number of corners can be altered.
%  All argument have default values except xyp.
%  Default a black dot with 16 corners.
%  Singleton are automatically expanded to match the other arguments.
% INPUT
%  xyp --    The complex position of each patch.
%  radius -- The complex radius to the corners of the patch.
%  color --  The color of each patch in the interval 0 to 1.
%            The scaling of colors then goes from black over red to white
%            If c is set to NaN a greyish color is used.
%  ncorn --  The number of corners in the patch.
%  ratio --  Determines the form of the patch.
% OUTPUT
%  The plot only.
% TRY
%  plotdot(irand(3), 0.1*rand(3), rand(3))
%  plotdot(irand(3),irand(3),rand(3),ceil(rand(3)*6),rand(3))
%  try also the virtual artist:
%  plotdot(mplus(1:5,i*(1:5)'), 0.5*rand(1,5), 0.5+2*rand(5,1),4)

% by Magnus Almgren 990225

% Set color table with last color for NaNs.
colormap([hot(64); 0.9*ones(1,3)]);

% Clean up variables.
if ~exist('radius','var')  % If no radius argument is present set radius to 1
  radius = 1;
end
if ~exist('color','var')   % If no color argument is present set color to 0
  color = 0;
end
if ~exist('ncorn','var')   % Number of corners of patch
   ncorn = 16;
end
if ~exist('ratio','var')   % Quotient between length and width
   ratio = 1;              % Of the patch relative to the radius
end

% Adjust size of inputs.
[xyp, r, c, ncorn, rat] = ...
adjsiza(xyp, radius, color, ncorn, ratio);
xyp = xyp(:).';  % make all variables point along 2nd dimension
r = r(:).';
c = c(:).';
ncorn = ncorn(:).';
rat = rat(:).';

ncornm = max(ncorn);
% set NaNs to 2 and give them the special nancolor later
nanind = isnan(c);
c = max(0,min(1,c));
c(nanind) = 2;

% make the patch shape 
% the number of rows is determined by the patch with most corners
cornv = mprod((0:ncornm-1)',1./ncorn); 
cornv(cornv>=1) = 0;  % reset all excessive vertices
% adjust so that radius is perp to one side of the patch
% cornv = mplus(cornv,0.5./ncorn); 

dot = exp(i*2*pi*cornv);
dot = mprod(real(dot),rat) + mprod(i*imag(dot),1./rat);

% make patchedges and colors in corners of patches
xy = mplus(xyp, mprod(r, dot));
cxy = adjsiza(c, dot);

% Make the plotting.
if size(xy,2)>0
  clf;
  h = patch(real(xy),imag(xy), cxy); % draw all objects
  set(h,'Edgecolor','none'); % take away edges
  axis('equal');  % isotropic view
  % set coloraxis to adjust for NaNcolor
  caxis([0 eps+1+1/(size(colormap,1)-1)]);
end
if nargout > 0 % deliver a handle if asked for
   res = h;
end
