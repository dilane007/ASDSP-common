function setpath(rem)
% DESCRIPTION setpath(rem)
%  Sets matlabpath to functions in the simulator rune.
%  Removes the path when any argument is present.
%  An advice: Do not edit files in the rune directory. Move a copy
%  to myOwn directory and make desired changes.
%  All new paths are placed on top in order to avoid conflict
%  with other functions with the same name but other functionality
% INPUT 
%  -- rem  if present will remove the path instead 
% SEE ALSO 
%  path, addpath, rmpath

% by Magnus Almgren 980219 revised 011009

runep = pwd;

str{1} = [runep ''];
str{2} = [runep '/examples']; 
str{3} = [runep '/runemain']; 
str{4} = [runep '/runetools'];

for j = fliplr(1:length(str)) % last added first
  if ~exist('rem','var')
    addpath(str{j}); % add path
  else
    rmpath(str{j});  %remove path
  end
end
