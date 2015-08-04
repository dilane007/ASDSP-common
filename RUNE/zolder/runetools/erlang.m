function b = erlang(a, n) % erlang b formula for any matrix sizes
% DESCRIPTION b = erlang(a, n) 
%  Erlang b formula for any matrix sizes.
%  Input arguments will extend singleton dimensions of each input 
%  argument to match the other arguments.
% INPUT
%  a --  The offered traffic.
%  n --  The available number of servers.
% OUTPUT
%  b --  The resulting blocking probability.
% TRY 
%  erlang((0:0.1:1)',1:2)

% by Magnus Almgren 980930

newdim = firstsing(a,n); %Find first not used dimension.
nv = flatten(0:max(n(:)),newdim); % Make a ramp in that dimension.
%gamln = gammaln(nv+1); % Calc nat log of all factorials that is used.
[a, n, nv] = adjsiza(a,n,nv); % Make all args to the same size.
loga = -log(mdiv(1,a));
t = loga.*n - gammaln(n+1); % nominator
b = 1./sum(exp(loga.*nv - gammaln(nv+1) - t).*(n>=nv),newdim); % denominator

% The function is caculated in logarithms and all terms in
% the denominator is divided by the nominator for a change.
