% runetest2
% A second example of how to use runefg. A system is created and simulated for 30 
% time instances. Then the number of users over time are plotted.

% by Magnus Almgren 010923
par = setparg; % load default parameter settings
sta = [];
sys = [];
time = 0;
nusers = 0;
%par.mht=0;
for iter = 1:30
 [res, par, sta, sys] = runefg(par, sta, sys);
%par.mht = inf;
 time = [time; sta.time];
 nusers = [nusers; length(sta.xym)];
end
% show some result as a plot
plot(time,nusers,'.-')
xlabel('time [s]')
ylabel('Number of users')
% $Id: runetest2.m,v 1.3 2004/03/15 14:58:03 olav Exp $
