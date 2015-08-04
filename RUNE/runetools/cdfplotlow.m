function cdfplotlow(x, plottype)
% DESCRIPTION cdfplotlow(x, plottype)
%  CDF plot of the input matrix for each
%  column separately. By use of a log scale 
%  the lower part of the input is highlighted.
% INPUT
%  x --         a real matrix (no Nans or Infs)
%  plottype --  String describing the plot, e.g. 'r*'
%               plots red stars.
% OUTPUT
%  the plot only
% SEE ALSO
%  cdfplothigh, cdfplotmed
% TRY
%  cdfplotlow(randn(10000,1))

% by Magnus Almgren 000512 modified by Sofia Mosesson 000711

x = sort(x);
ytemp = linspace(0,1,1+2*size(x,1))';
y = adjsiza(ytemp(2:2:end-1),x);
% Reduce the number of points in the plot.
nlen = 200; % 200 => 1000 elements into 500
vec = []; 
j = -1;
while size(vec)< size(x,1) 
 j = j+1;
 vec = [vec; 
   flatten(mprod([1; zeros(2.^j-1,1)],ones(1,nlen)))];
end
vec = logical(vec(1:size(x,1)));
vec(y>0.9)=logical(0); % Truncate the upper part of distribution.
if exist('plottype', 'var')
 plot(x(vec,:),lin2db(y(vec,:)), plottype)
else
 plot(x(vec,:),lin2db(y(vec,:)))
end
set(gca,'ylim',[-20 0]); % Reduce the yaxis.
% Set proper labels.
set(gca,'ytick',lin2db([1:10 20:10:100]/100));
labels=[
'  1';'  2';'  3';'   ';'  5';'   ';'   ';'   ';'   ';
' 10';' 20';' 30';'   ';' 50';'   ';'   ';'   ';'   ';
'100'];
set(gca,'yticklabel',labels);
ylabel('C.D.F.  [%]');
grid on;

% $Id: cdfplotlow.m,v 1.1 2004/02/19 17:27:42 bogdant Exp $
