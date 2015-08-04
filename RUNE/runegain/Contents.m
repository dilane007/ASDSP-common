% RUNEMAIN  functions needed for any kind of system
%
% Main functions
%   runefg      - a function that exercises most of the functions bleow
%   setparg     - sets all needed parameters to runefg
%
% System deployment
%   crecluster  - creates one cluster
%   crecells    - comples base station coord.s and cell center vectors
%   crelognmap  - map for simulating lognormal fading
%   creraylmap  - Rayleigh fading map with complex samples
%
% User behaviour
%   mobmove     - initiates positions and moves mobiles
%
% Propagation
%   pathgain    - the gain in dB between the mobiles and the bases
%   antennagain - antenna gain as a function of angle
%   uselognmap  - correlated lognormal values for shadow fading
%   useraylmap  - complex samples of multipath fading
%
% Plots and display
%   plothex     -  plots the hexagon cell pattern.
%
% Miscelaneous
%   wrapinto    - wraps positions back into the system area
%   ci2rber     - maps signal to interference ratio into raw bit error rate
%   nmap        - determines the size of the lognormal map

% created by Bogdan Timus modified 040218
% $Id: Contents.m,v 1.2 2004/03/15 14:59:21 olav Exp $
