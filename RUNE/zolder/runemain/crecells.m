function [xyb, fib, rombvec] = crecells(cellradius, sps, km, lm)
% DESCRIPTION [xyb, fib, rombvec] = crecells(cellradius, sps, km, lm)
%  Creates basestations. Their positions in complex coordinates 
%  is stored in xyb. 
% INPUT
% cellradius --  Complex radius from the base to the center of the hexagonal cell.
% sps --         Sectors per site usually 1 (omni cells) or 
%                3 (120 degrees sector cells).
% km --          See below.
% lm --          Integer values giving the size of the simulated system according to
%                km^2+lm^2+km*lm. 
% OUTPUT
% xyb --         Base station positions in complex coordinates.
% fib --         Complex vectors from the bases to the center of the cell.
%                In the omni case fib vector elements are zero.
% rombvec --     Two vectors that span the area the system is created on.
% TRY            
%  plot(crecells(1000,3,2,3),'*') 
%  3 cells/site, 19 sites 

% by Magnus Almgren 010214

[xys, clustervecs]= crecluster(km,lm);
xysites = flatten(xys,2); % 2nd dimension
% Concatenate clusters in two dimensions.
spsvec = flatten(0:sps-1,3); % 3rd dimension
fibd = cellradius*exp(i*2/3*pi*spsvec);  
[xyb, fib] = adjsiza(xysites, fibd);
xyb = cellradius*3*flatten(xyb,2); % base station positions
rombvec = clustervecs*cellradius*3; % adjust cells around origo
if mod(length(xysites),3)==1 % shapes more regular cell layout
 xyb = xyb-xyb(1);
end 
xyb = wrapinto(xyb, rombvec, 'hex'); % adjust cells around origo
xyb = xyb-mean(xyb); % center the cells
fib = flatten(fib,2);  % xyb & fib in second dimension
if sps == 1 % Modify for the omin case.
 fib = 0*fib;
 xyb = xyb/sqrt(3); % Adjust to correct cellradius.
 rombvec = rombvec/sqrt(3);
end
