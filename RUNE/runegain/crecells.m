function [xyb, fib, rhombvec] = crecells(cellradius, sps, km, lm, kn, ln)
% DESCRIPTION
% [xyb, fib, rhombvec] = crecells(cellradius, sps, km, lm, kn, ln)
%  Create complex base station coordinates and cell center vectors  
% INPUT
%  cellradius --  Complex radius from the base to the center of the hexagonal cell.
%  sps --         Sectors per site 1 (omni cells) or 3 (120 degrees sector cells).
%  km --          See below.
%  lm --          Integer values giving the site-cluster-size according to
%                 km^2+lm^2+km*lm. 
%  kn --          See below.
%  ln --          Integer values giving the number of clusters according to
%                 kn^2+ln^2+kn*ln.  ln is optional and default value is 0.
% OUTPUT
%  xyb --         Base station positions in complex coordinates.
%  fib --         Complex vectors from the bases to the center of the cell.
%                 In the omni case fib vector elements are zero.
%  rhombvec --    Two complex vectors that span the area of the system.
% SEE ALSO
%  crecluster
% TRY            
%  plot(crecells(1000,3,2,3,2),'*') 
%  3 cells/site, 19 sites/cluster, 4 clusters 

% by Magnus Almgren 000505 revised 030717

if nargin < 6
 ln = 0;
end
if nargin < 5
 ln = 1;
 kn = 0;
end
if sps == 1
 fibv = 0; % Zero to indicate no specific direction
 sitev = sqrt(-3)*cellradius;
else % sps is assumed to be 3 but also 6,12,18 would make sense
 fibv = cellradius*exp(i*2*pi*flatten(0:sps-1,3)/sps); % 3rd dimension
 sitev = -3*cellradius;
end

% Complex Cell positions within a cluster
[xy rvc] = crecluster(km, lm, sitev);
xyc = flatten(xy, 2); % 2nd dimension

% Complex cluster positions within the system
[xy rhombvec] = crecluster(kn, ln, rvc(1));
xys = flatten(xy, 4); % 4th dimension

% Combine xys, xyc, fibv to its final size 
[xyb, fib] = adjsiza(mplus(xys, xyc), fibv);

% xyb & fib in second dimension
xyb = flatten(xyb,2); % Complex base station positions 
fib = flatten(fib,2); % Complex vector pointing to the center of the cell 

xyb = xyb-mean(xyb); % adjust cells around origo

% $Id: crecells.m,v 1.2 2004/03/11 15:01:30 olav Exp $
