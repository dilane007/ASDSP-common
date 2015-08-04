function cdfplothigh(x, plottype)
% DESCRIPTION cdfplothigh(x, plottype)
%  CDF plot of the input matrix for each
%  column separately. By use of a log scale 
%  the higher part of the input is highlighted.
% INPUT
%  x --         a real matrix (no Nans or Infs)
%  plottype --  String describing the plot, e.g. 'r*'
%               plots red stars.
% OUTPUT
%  only the plot
% TRY 
%  cdfplothigh(randn(10000,1))

% by Magnus Almgren 000512 modified by Sofia Mosesson 000711

x = sort(x);
ytemp = linspace(0,1,1+2*size(x,1))';
y = adjsiza(ytemp(2:2:end-1),x);
% reduce the number of points in the plot 
nlen = 200; % 200 => 1000 elements into 500
vec = []; 
j = -1;
while size(vec)< size(x,1) 
 j = j+1;
 vec = [vec; 
 flatten(mprod([1; zeros(2.^j-1,1)],ones(1,nlen)))];
end
vec = flipud(logical(vec(1:size(x,1))+1));
vec(y<0.1)=logical(0); % truncate the upper part of distribution
if exist('plottype', 'var')
 plot(x(vec,:),-lin2db(1-y(vec,:)), plottype)
else
 plot(x(vec,:),-lin2db(1-y(vec,:)))
end
set(gca,'ylim',[0 20]);
% set proper labels
set(gca,'ytick',-lin2db(1-[0:10:90 91:1:99]/100));
labels=[
 '  0';
 '   ';'   ';' 30';'   ';'   ';'   ';' 70';' 80';' 90';
 '   ';'   ';' 93';'   ';'   ';'   ';' 97';' 98';' 99';
];
set(gca,'yticklabel',labels);
ylabel('C.D.F.  [%]')
grid on;
