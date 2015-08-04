function setpath(rem)
% DESCRIPTION
%  Sets matlabpath to functions in the simulator rune.
%  Removes the path when any argument is present.
%  An advice: Do not edit files in the rune directory. Move a copy
%  to myOwn directory and make desired changes.
%  All new paths are placed on top in order to avoid conflict
%  with other functions with the same name but other functionality
% INPUT 
%  rem -- if present will remove the path instead 
% SEE ALSO 
%  path, addpath, rmpath

% by Magnus Almgren 980219 revised 031113

runep = pwd;

str{1} = [runep ''];
str{2} = [runep '/examples']; 
str{3} = [runep '/runetdma']; 
str{4} = [runep '/runecdma']; 
str{5} = [runep '/runegain']; 
str{6} = [runep '/runetools'];

for j = fliplr(1:length(str)) % add in reverse order
  if ~exist('rem','var')
    addpath(str{j});
  else
    rmpath(str{j});
  end
end

% $Id: setpath.m,v 1.2 2004/03/11 15:00:34 olav Exp $
