function movieterm(sys,sta,vec)
% DESCRIPTION
%  movieterm(sys,sta,vec)
%  Shows how mobiles move around in an already simulated system
% INPUT
% sys -- System parameters from a simulation
% sta -- State information for each snapshot
% vec -- Optional, determines which snapshots of the simulations should be plotted
% TRY
% 
% SEE ALSO
% showterm
if ~exist('vec','var')
 vec = 1:length(sta.m);
end
% by Magnus Almgren 010131
for j=vec
 showterm(sys,sta,sta.m(j))
 pause(.3)
end

% $Id: movieterm.m,v 1.2 2004/03/11 15:00:54 olav Exp $
