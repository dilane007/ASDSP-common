function plotnorm(varargin)
% DESCRIPTION plotnorm(x,y,plottype)
%  As plot but with y axis scaled by the 
%  inverse Q function distribution. Otherwise 
%  most of the functionality is as within plot.m.
%  plotnorm does not tkae more than 3 input arguments though.
% INPUT
%  x        -- xaxis arguments
%  y        -- yaxis arguments between 0 and 1
%  plottype -- String describing the linetype, e.g. 'r*'
%              plots red stars.
% OUTPUT
%  only the plot
% SEE ALSO
%  plot, plotnh, ploth, cdfplothigh
% TRY 
%  plotnorm(-3:0.1:3,qfunc(-3:0.1:3),'r.-')
%  plotnorm(sort(randn(1,1000)),(1:1000)/1000,'.')

% by Magnus Almgren 040121
if isstr(varargin{end})
 varargin{end-1} = qfuncinv(1-varargin{end-1}); 
else
 varargin{end}   = qfuncinv(1-varargin{end}  ); 
end
plot(varargin{:})

set(gca,'ylim',[-3 3]);
% set proper labels
v = 1:9;
v1 = [0.001*v  0.01*v 0.1 0.2 0.3 0.4];

set(gca,'ytick',qfuncinv(1-[v1 0.5 1-fliplr(v1)]));
labels=[
 '0.001';'0.002';'     ';'     ';'0.005';'     ';'     ';'     ';'     ';
 '0.01 ';'0.02 ';'     ';'     ';'0.05 ';'     ';'     ';'     ';'     ';
 '0.1  ';'0.2  ';'0.3  ';'0.4  ';'0.5  ';'0.6  ';'0.7  ';'0.8  ';'0.9  ';
 '     ';'     ';'     ';'     ';'0.95 ';'     ';'     ';'0.98 ';'0.99 ';
 '     ';'     ';'     ';'     ';'0.995';'     ';'     ';'0.998';'0.999';
];
set(gca,'ylim',qfuncinv(1-[0.001 0.999]));
% set proper labels
v = 1:9;
v1 = [0.001*v  0.01*v 0.1 0.2 0.3 0.4];

set(gca,'ytick',qfuncinv(1-[v1 0.5 1-fliplr(v1)]));
labels=[
 '0.001';'     ';'     ';'     ';'0.005';'     ';'     ';'     ';'     ';
 '0.01 ';'     ';'     ';'     ';'0.05 ';'     ';'     ';'     ';'     ';
 '0.1  ';'     ';'     ';'     ';'0.5  ';'     ';'     ';'     ';'0.9  ';
 '     ';'     ';'     ';'     ';'0.95 ';'     ';'     ';'     ';'0.99 ';
 '     ';'     ';'     ';'     ';'0.995';'     ';'     ';'     ';'0.999';
];
set(gca,'yticklabel',labels);
ylabel('')
grid on;

% $Id: plotnorm.m,v 1.1 2004/02/19 17:27:45 bogdant Exp $
