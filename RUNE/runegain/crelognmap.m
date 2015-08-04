function [lognmap, mapvec] = crelognmap(xyb, rhombvec, corrdist, nlayer)
% DESCRIPTION
% [lognmap, mapvec] = crelognmap(xyb, rhombvec, corrdist, nlayer)
%  Generates a lognormal map used to generate lognormal fading
%  during a simulation. The upper border of the map has the same values 
%  as the lower border of the map. It is the same for the left and right borders
%  Within rhombvec a certain number of maps are fitted to avoid resonace with base
%  station placement. The code is closely related to uselognmap. 
% INPUT
%  xyb --      Used to determine the size of the map.
%              If empty rhombvec => mapvec. 
%  rhombvec -- Used to determine the size of the map.
%  corrdist -- The distance until the correlation in the map has
%              decreased to 1/e.
%  nlayer  --  The number of maps to be created ( Layered in 3rd dimension.
% OUTPUT
%  lognmap --  A square matrix of real values. The mean of all values are 0
%              and the standard deviation is 1.  The map spans atleast two dimensions
%              and possbly also the 3rd to store nlayer independent map
%  mapvec --   Two comlex vector elements that are used to move
%              the map to one mapsize.
% TRY 
%  mesh(crelognmap([],[1 i],0.1))
% SEE ALSO 
%  uselognmap, nmap

% by Magnus Almgren 000515 revised 010713 added nlayer

if ~exist('nlayer','var')
 nlayer = 1; % default only one map
end

border = 1; % repeated border from the other side of map
siz = 2^8;  % size of side of map

mapvec = rhombvec;
if ~isempty(xyb)
 mapvec = rhombvec ./ nmap(rhombvec, xyb, corrdist);
end

v1=linspace(-mapvec(1)/2, mapvec(1)/2, siz+1);
v2=linspace(-mapvec(2)/2, mapvec(2)/2, siz+1);

r = abs(mplus(fftshift(v2(1:siz)),fftshift(v1(1:siz)).'));
hf = sqrt(real(fft2(exp(-r/corrdist))));

for j = nlayer:-1:1 % reserve space at first iteration
 % calculate the map from white noise 
 z = real(ifft2(fft2(randn(size(hf))).*hf)); 
 rm = z([1:end 1:border],[1:end 1:border]) ./std(z(:));  % normalize the map 
 lognmap(1:size(rm,1),1:size(rm,2),j) = rm;  
end

% $Id: crelognmap.m,v 1.2 2004/03/11 15:01:31 olav Exp $
