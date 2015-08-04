function plothex(xyb, fib, chgroup)
% DESCRIPTION
%  plothex(xyb, fib, chgroup)
%  Plots the homogeneous hexagon cell pattern with BS identities.
% INPUT
%  xyb     --  Base station coordinates, given as a complex row vector.
%  fib     --  The base station antenna vector, given as a complex row
%              vector pointing from base to middle of cell.
%  chgroup --  Row vector. Contains the channel group number of the cell.
%              This number is used to set the color of the cell.
% SEE ALSO
%  crecells
% TRY
%  plothex(0,0)
%  plothex([0 1],[0 0])
%  plothex([0 1 2],[0 0 0],[1 2 3])

% By Magnus Almgren 010129 revised 040202 MA

% Calculate cell radius
if all(fib==0)       
 % omni cell (fib==0)
 xybu = unique(xyb);
 if length(xybu)>1
  xyb2b = xybu(minind(abs(xybu(2:end)-xybu(1)))+1)-xybu(1);
  cellradius = mplus(fib,xyb2b/sqrt(-3));
 else
  cellradius = 1000i; % the case with one omnibase only
 end
 tpos = cellradius(1)/4; % Place text slightly off the cell center
else
 % Directional antennas
 cellradius = fib;
 tpos = 0; % Place text in the middle of the cell.
end

% Plot the hexagonal pattern
% Each column of 'points' contain the corner points of each cell
points=mplus(xyb,fib,exp(i*pi*(0:6)/3).'*cellradius);

if ~exist('chgroup','var')
 plotnh(real(points),imag(points),'k');
else
 patch(real(points),imag(points),mprod(ones(7,1),0.3+0.7*chgroup/max(chgroup)));
 caxis([0 1]);
end

% Plot base positions
ploth(real(xyb),imag(xyb),'ro') 
axis('equal')

% Plot BS id
ts=get(gcf,'DefaultTextFontSize'); % Preserve font size
set(gcf,'DefaultTextFontSize',7);  % Set font size to 7
pos = xyb + fib + tpos;            % BS text pos
for s=1:length(xyb)
 text(real(pos(s)),imag(pos(s)),num2str(s),'HorizontalAlignment','center')
end
set(gcf,'DefaultTextFontSize',ts); % Restore old font size

% $Id: plothex.m,v 1.2 2004/03/11 15:01:31 olav Exp $
