% runetest3
% The third example of how to use runefc.

% by Magnus Almgren 010923
clear sys
par = setparc; % load default parameter settings
par.mht = 0; % infinite time in order to get into full traffic conditions
par.maxiter = 1;
par.offtraf = 10;
par.km = 4;
sta = []; % reset state variable 
% avoid to recreate the system variable each time this script is called
if ~exist('sys','var') % use previosly created system variable if it exists
 sys = [];
end

[res, par, sta, sys] = runefc(par, sta, sys); % create a nice init state

% change parameter settings
par.mht = inf; % keep traffic alive with infinite mean hold time
par.maxiter = 2;
sta.t = 0; % init sample time 
[res, par, sta, sys] = runefc(par, sta, sys);
% show some result as a plot
figure(3)
hist(sta.iumb(isfinite(sta.iumb)),100)
break
islinkmbt = isfinite(cat(3,res(:,:).pumb));
putm = swdims(max(cat(3,res(:,:).pumb),[],2),[3 2])';
cutm = swdims(linsum(cat(3,res(:,:).cumb),2),[3 2])';
sirutm = swdims(linsum(cat(3,res(:,:).sirumb),2),[3 2])';
pdtm = swdims(max(cat(3,res(:,:).pdmb),[],2),[3 2])';
cdtm = swdims(linsum(cat(3,res(:,:).cdmb),2),[3 2])';
sirdtm = swdims(linsum(cat(3,res(:,:).sirdmb),2),[3 2])';



% $Id: runetest3.m,v 1.3 2004/03/15 14:58:03 olav Exp $
