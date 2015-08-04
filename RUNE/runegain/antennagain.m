function antg = antennagain(fi,nantw)
% DESCRIPTION
% antg = antennagain(fi,nantw)
%  Returns antenna gain in dB given an anagle in radians. The antenna lobe is approximated
%  with a (sin(fi)/fi)^2 within the sector.
% INPUT
%  fi --     Direction towards antenna [radians]
%  nantw --  Nominal antenna width. Default 1/3.
%            Used to change the antenna width.
% OUTPUT
%  antg --   A row vector containing the gain in each 1 degree direction.
%            The length of the vector is 360 where last index corresponds 
%            to zero degrees and first index to 1 degree.
% SEE ALSO
%  pathgain
% TRY
%  fi = linspace(-pi,pi,361).'; 
%  plot(fi,antennagain(fi,1/3))
%  plot(fi,antennagain(fi,1)) => omni
%  plot(fi,antennagain(fi,1./(1:12)))
%  polar(fi,db2lin(antennagain(fi,1/3)/3.5))  % the space coverage

% by Magnus Almgren 030717 MA
if ~exist('fi','var')
 fi = (1:360)/360*2*pi;
end
[fi nantw] = adjsiza(fi, nantw);
blg = -30; % relative backlobe gain
maxg = 12.2; % max antenna gain in forward direction for the omni case
lw = 0.75207; % Fitted to give 10.53 dB drop of gain @ 60 degrees <=> 35*log10(0.5)
              % for the case when nantw = 1/3.
antg = max(blg,ag(mdiv(wrap(fi),nantw)*lw)-lin2db(nantw))+maxg;
antg(nantw>=1) = maxg; % For the omnilobe case 

function fout = wrap(f) % wrap any angle into -pi to pi
fout = mod(f+pi,2*pi)-pi; 

function g = ag(f) % sinc lobe shaped antenna
fi = min(pi,abs(f)); % fi is limited  between 0 pi/2
g = 2*lin2db(mdiv(sin(fi),fi)); % power gain [dB]
g(fi==0) = 0; % fix the case 0/0

% $Id: antennagain.m,v 1.2 2004/03/11 15:01:30 olav Exp $
