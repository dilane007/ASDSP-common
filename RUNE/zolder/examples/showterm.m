function showterm(sys,sta,mobid)
% function showterm(sys,sta,mobid)

% by Magnus Almgren 010131
plothex(sys.xyb,sys.fib)
ish = ishold;
hold on

bind = ismember(sta.m, mobid);
[xymm, xybm, bindm] = adjsiza(sta.xym, sys.xyb, bind);
bindmm = logical(mprod(bindm,isfinite(sta.pumb)));
links = [xymm(bindmm) xybm(bindmm)].';
if ~isempty(links)
 plot(links,'b-')
 plot(sta.xym(bind),'m*')
end
if ish
 hold on
else
 hold off
end
