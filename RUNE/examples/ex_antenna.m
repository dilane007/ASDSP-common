function g360deg = ex_antenna(par)
% DESCRIPTION 
%  g360deg = ex_antenna(par)
%  Example of gain when going around a base station.
%  The plots show the gain between a sinc-antenna and
%  a mobil at different standard deviations for the 
%  lognormal fading.
% INPUT
%  par --          Basic enviromental entitities. If not present
%                  setparg is default
% OUTPUT
%  g360deg --      Gainmatrix with size 360 by 1. One for each degree
%                  the antenna at radius 500.
% TRY
%  ex_antenna

% by Magnus Almgren 040206

% Set simulation parameter p if necessary.
setifnotexist('par','setparg') % Default par = setparg;
par.sigma = 0; % no lognormal fading

% Fake mobile positions on 500 meter radius
Radius = 480;
xym = Radius*exp(i*2*pi*(1:360)'/360);


xyb = 0; % Cell position
fib = 1; % Antenna direction
asps = 3; % Antenna sectors per site => 120 degree antenna
rhombvec = []; % No wraparound
% No lognormal fading map is needed when sigma == 0

% Gain when traveling around the base on a constant distance.
g360deg = pathgain(xym,  xyb, fib, asps, rhombvec, ...
  par.gainconst, par.alpha, par.sigma);

 % Plot it
 clf
 plot3(real(xym),imag(xym),g360deg)
 xlabel('x-direction')
 ylabel('y-direction')
 zlabel('gain [dB]')
 title('Gain when traveling around a Base')
 grid on
 
% $Id: ex_antenna.m,v 1.3 2004/03/15 14:58:02 olav Exp $
