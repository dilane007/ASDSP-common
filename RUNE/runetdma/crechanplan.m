function obk=crechanplan(nb, nk, ncluster);
% DESCRIPTION obk=crechanplan(nb,nk,ncluster)
%  Makes a "frequency" plan with cluster size nb/ncluster.^2. 
%  The cells are numbered in the same way as in crecells. 
%  To get a correct symmetric frequency plan (nk*ncluster.^2)/nb 
%  has to evaluate into an integer.
% INPUT 
%  nb --        Number of base stations.
%  nk --        Number of channels in the system.
%  ncluster --  number of clusters.
% OUTPUT
%  obk --       Binary matrix, bases by channels.
%               obk(j,k)=1, if base j is an allocated channel.
% SEE ALSO     
%  crecells
% TRY          
%  spy(crechanplan(12,24,3))

cellpclust = ceil(nb/ncluster); % clustersize;
obk = repmat(eye(cellpclust),[ncluster, ceil(nk/cellpclust)]);
obk = obk(1:nb,1:nk); % Correct the size if
                      % (nk*ncluster)/nb was not an integer.




% $Id: crechanplan.m,v 1.1 2004/02/19 17:27:33 bogdant Exp $
