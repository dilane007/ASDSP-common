% runetest1 by Magnus Almgren 010216
if ~exist('sys','var')
 par = setpar;
 par.maxiter = 1;
 par.dt=inf; %  
 [res, par, sta, sys] = runef(par);
 par.mht = inf;
 par.dt=1; %  
end
[res, par, sta, sys] = runef(par, sta, sys);
plot(linsum(sta.sirumb,2),max(sta.pumb,[],2),'.')
xlabel('SIR uplink [dB]')
ylabel('Power uplink [dBm]')