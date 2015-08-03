function setNotDone(segNumIndex)

%function setNotDone(segNumIndex)
%
% Input:
%   segNumIndex = n x 2 [segNum zeros(n,1)]
%
% This function clears the appropriate flags to indicate that there some
% operation i progress. (It sets a spinlock.)

global ALL_DONE;

for i=1:size(segNumIndex,1),
    ALL_DONE(segNumIndex(i,1)+1,segNumIndex(i,2)+1) = 0;
end
