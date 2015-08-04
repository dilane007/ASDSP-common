% DESCRIPTION
%  Sets matlabpath to functions in the simulator rune.
%  All new paths are placed on top in order to avoid conflict
%  with other functions with the same name but other functionality.
%  This is essentially a script wrapper for the setpath function. But
%  since MATLAB does not allow calling a function that is outside the
%  path (or the current directory) it ha to be done this way. How long
%  will Comsol continue to not get the programming language right, ARGH!!!
%  Essentially this script should be calles as 'run ..../setp'
% SEE ALSO 
%  setpath, run

setpath;


% $Id: setp.m,v 1.2 2004/03/11 22:58:02 olav Exp $
