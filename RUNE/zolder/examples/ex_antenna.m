function g360deg = ex_antenna(p)
% DESCRIPTION ex_antenna(p)
%  Example of gain when going around a base station.
%  The plots show the gain between a sinc-antenna and
%  a mobil at different standard deviations for the 
%  lognormal fading.
% INPUT
%  p --            Basic enviromental entitities. If not present
%                  the function set default values to parameters
%                  below.
%  .cellradius --  cell radius [m]
%  .sps --         number of sectors per site
%  .alpha --       distance attenuation coefficient
%  .raa --         down link correlation (typical 0.5)
%  .corrdist --    correlation distance for the lognormal fading
%  .seed --        seed to all random sequencies in the simulation
% OUTPUT
%  g360deg --      Gainmatrix with size 360 by 3. The three columns 
%                  represents std at 0, 2, and 6 dB for the lognormal
%                  fading. The rows represent the 360 degrees around
%                  the antenna at radius 500.
% TRY
%  ex_antenna

% by Magnus Almgren 000517 modified by Sofia Mosesson 000628

% Set simulation parameter p if necessary.
if ~exist('p','var')
 p.cellradius = 1000;  % cell radius [m]
 p.sps = 3;	       % number of sectors per site
 p.alpha = 3.5;	       % distance attenuation coefficient
 p.raa = 0.5;          % down link correlation (typical 0.5)
 p.corrdist = 110;     % correlation distance for the lognormal fading
 p.seed = 1;           % seed to all random sequencies in the simulation
end

% Fake mobile positions and speed.
xym = 500*exp(i*2*pi*(1:360)'/360);

% Generate base station position and directions.
rombvec = 10000*exp([0 i*2*pi/3]);
xyb = 0; 
fib=1000+1000i;

% Antenna attenuation for all directions, size == [360 1].
if p.sps==3
 lobevector = sinclobe;    
else 
 lobevector = omnilobe;
end

sigmas = [0 2 6];
gainconsts = [21 19.1 13.4]; % Different gainconst to remain the total radiated power.

for j=1:3
 p.sigma = sigmas(j);
 p.gainconst = gainconsts(j);
 % Create a lognormal map.
 if p.sigma > 0 % Is a lognormal map needed (takes a few seconds to generate)?
  % The lognormal map is dependent on the seed.
  oseed = setseed(p.seed);  % Set seed of pseudo random generator for the map.
  [lognmap, mapvec] = crelognmap(xyb, rombvec, p.corrdist); 
  setseed(oseed);
 else
  lognmap = 0;  % Give fake arguments to pathgain.
  mapvec = 0;  % The values doesn't matter anyway.
 end

 % Calculate the gain matrix.
 g = pathgain(xym,  xyb, fib, rombvec, ...
  p.gainconst, p.alpha, p.sigma, p.raa, ...
  lobevector, lognmap, mapvec);
 subplot(3,1,j)
 a1 = xym(:,[1 1]);
 
 mesh(real(xym(:,[1 1])),imag(xym(:,[1 1])),g(:,[1 1]))
 axis([-500 500 -500 500 -100 -50])
 xlabel('x-direction')
 ylabel('y-direction')
 zlabel('gain [dB]')
 if j==1
  g360deg = g;
  title('Antenna gain with: no lognormal fading')
 elseif j==2
  g360deg = [g360deg, g];
  title('std(lognormal fading) = 2 dB')
 else
  g360deg = [g360deg, g];
  title('std(lognormal fading) = 6 dB')
 end
end







