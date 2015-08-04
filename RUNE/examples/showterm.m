function showterm(sys,sta,mobid)
% DESCRIPTION
%  showterm(sys,sta,mobid)
%  Plots specified mobiles in the system. 
% INPUT
% sys -- System parameters
% sta -- Status information from a simulation
% mobid -- The id numbers of the mobiles to plot
%

% by Magnus Almgren 010131
plothex(sys.xyb,sys.fib)
ish = ishold;
hold on

if nargin<3, mobid=(1:length(sta.m))'; end;
bind = ismember(sta.m, mobid);
[xymm, xybm, bindm] = adjsiza(sta.xym, sys.xyb, bind);
bindmm = logical(mprod(bindm,isfinite(sta.pumb)));
if size(xymm,1)==1,
  links = [xymm(bindmm).' xybm(bindmm).'].';
else
  links = [xymm(bindmm) xybm(bindmm)].';
end;
if ~isempty(links)
  plot(links,'b-')
  plot(sta.xym(bind),'m*')
end
if ish
 hold on
else
 hold off
end

% $Id: showterm.m,v 1.3 2004/03/15 14:09:02 bogdant Exp $
