function [xys, clv] = crecluster(km,lm,d)
% DESCRIPTION
% [xys, clv] = crecluster(km,lm,d)
%  Creates one cluster containing km^2 + lm^2 + km*lm sites.
%  These terms are handled as three parallellograms 
%  and then combined to a cluster.
% INPUT
%  km --   See below.
%  lm --   Integer. At least one of km and lm is >0.
%  d --    Complex vector to nearest site. Default 1.    
% OUTPUT
%  xys --  The positions of the sites in complex coordinates.
%  clv --  Two vectors used to repeat clusters next 
%          to each other. The vectors tells the displcement in complex 
%          coordinates from the cluster to its nearest copies.
% TRY 
%  [xys, clustervecs] = crecluster(2,3), plot(xys,'*')
%  figure, plot(mplus(xys.',[0 -clustervecs clustervecs]),'*')
%  plot(crecluster(4,5),'.-')

% by Magnus Almgren 990716 revised 031114 MA

% Set defaults
if nargin < 2, lm = km+1; end
if nargin < 3,  d = 1;    end

e = exp(i*2/3*pi*(0:2));   % vectors used to span the cluster

kv = 0:km-1; 
lv = 0:lm-1;

[m1 m2] = meshgrid(kv*e(1),kv*e(2)); % meshgrid can handle [], mplus can not
skk = flatten(m1+m2)-e(3);

[m1 m2] = meshgrid(lv*e(1),lv*e(3));
sll = flatten(m1+m2);

[m1 m2] = meshgrid(kv*e(2),lv*e(3));
slk = flatten(m1+m2)+e(2);

clv = (km*e(1)-lm*e(3))*[1 e(2)].*d;
xys = [sll(:).' skk(:).' slk(:).'].*d;

% $Id: crecluster.m,v 1.2 2004/03/11 15:01:31 olav Exp $
