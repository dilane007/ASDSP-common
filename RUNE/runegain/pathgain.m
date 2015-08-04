function g = pathgain(xym, xyb, fib, asps, rhombvec, gainconst, alpha, ...
                      sigma, raa, lognmap, mapvec)
% DESCRIPTION
% g = pathgain(xym,xyb,fib,asps,rhombvec,gainconst,alpha,sigma,raa,lognmap,mapvec)
%  Caluculates the gain in dB between all mobiles and all bases. 
% INPUT
%  xym --        Mobile coordinates, given as a complex column vector.
%  xyb --        Base station coordinates, given as a complex row vector.
%  fib --        Base station antenna vector, given as a row vector. Points
%                in the antenna direction.
%  asps --       Antenna Sectors per site 3 <=> 120 deg sector
%                antenna, 1 <=> Omni antenna
%  rhombvec --   Two complex vectors spanning the rhombic area containing cells.
%  gainconst --  Gain at 1 meter distance. 
%  alpha --      Distance attenuation coefficient.
%  sigma --      Standard deviation for the lognormal fading in dB.
%  raa --        Down link correlation (typical 0.5). This parameter determines
%                the correlation for the lognormal fading on the links
%                between the base stations and one mobile.
%  lognmap --    Lognormal map used to create lognormal fading.
%  mapvec --     Two complex vectors that will determine the size of lognmap.
% OUTPUT
%  g --          Gain for all links in dB, given as a matrix 
%                one column for each base and one row for each mobile 
% TRY
%  rhombvec = exp([0 2*pi/3]*i)*10000;
%  gainconst = 21;
%  alfa = 3.5;
%  sigma = 0;
%  raa = 0.5;
%  [lognmap, lognmapvec] = crelognmap([],rhombvec,100);
%  Now. Only one mobile and one base station.
%  g = pathgain(0,0,1000,3,rhombvec,gainconst,alfa,sigma,raa,lognmap,lognmapvec)
%  xym = 1000*irandn(10,1); % ten users ramndomly placed
%  xyb = irand(1,2); % two base stations randomly placed
%  fib =  exp(i*100*rand(1,2)); % random antenna direction
%  asps = 3;
%  rhombvec = [0 0]; % no wrap around;
%  gainconst = 21;
%  alfa = 3.5;
%  sigma = 0;
%  raa = 0.5;
%  g = pathgain(  0,   1000,asps,rhombvec,gainconst,alfa,sigma)
%  g = pathgain(xym,xyb,fib,asps,rhombvec,gainconst,alfa,sigma)

% SEE ALSO 
%  crelognmap, uselognmap, crecluster

% by Magnus ALmgren 000510 revised 040202

if isempty(xym)
 g = zeros(0,size(xyb,2)); % Set to an empty matrix.
 return
end

% Wrap around in 7 positions. 
r = 0;  
if sum(abs(rhombvec))>0 % no rhombvec, no wrap around
 r = flatten(crecluster(1,2,rhombvec(1)),3); % wrap 7 possible positions
end

% xymbr = wrapinto(mplus(xym, -xyb),rhombvec,'hex'));
% wad = mplus(xymbr, r);
wad = mplus(xym, -xyb, r);

% Distance gain
% Make sure that the used distance is not less than 10 meters.
gatt = mplus(gainconst, -mprod(alpha ,lin2db(max(10,abs(wad)))));

% Angle attenuation between direction to mobiles and cell main direction added.
gant = antennagain(angle(mdiv(fib,wad)),1/asps);

% Select the position with highest gain of all wrap positions
g = max(gant+gatt,[],3);
clear gatt; % These may be big. 
clear gant;
clear wad;

% Lognormal fading with base station correlation.
if sigma ~=0
 % Create a random base offset.
 oseed = setseed(1); 
 maxdist = max(flatten(abs(mplus(xyb,-xyb.')))); % max distance 
 xyboffs = irand(size(xyb))*maxdist*10; % scramble base pos
 setseed(oseed);
 % Calculate the log normal gain
 g = g + sigma * mplus(... 
  sqrt(1-raa) * uselognmap(mplus(-xym,xyboffs),lognmap,mapvec), ...
  sqrt(raa)   * uselognmap(       xym         ,lognmap,mapvec) ...
  );
end

% $Id: pathgain.m,v 1.2 2004/03/11 15:01:31 olav Exp $
