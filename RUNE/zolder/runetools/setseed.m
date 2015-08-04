function oseed = setseed(val1, val2) % sets the seed to random generators
% DESCRIPTION oseed = setseed(val1, val2)
%  The seed is set to the MATLAB 4 generator 
%  and the old seed is delivered as vector output. 
%  If no input the seed is not altered.
% INPUT 
%  val1 --   A seed value, any real value.
%  val2 --   Same as val1, used to set the seed for randn. 
% OUTPUT
%  oseed --  The current seeds for rand and randn as a vector.
% TRY
%  oseed = setseed(3),
%  oseed = setseed(3,4), 
%  oseed = setseed
% SEE ALSO
%  rand('seed', randn('seed')

% by Magnus Almgren 990301

oseed = [rand('seed') randn('seed')]; % get the old seed
if nargin == 0     % set the new one
elseif nargin==1
 if length(val1)>1 
  rand('seed', val1(1)); % one input with two elements 
  randn('seed', val1(2));
 else
  rand('seed', val1);  % one input with one elements  
  randn('seed', val1);
 end
else 
 rand('seed', val1(1)); % two inputs
 randn('seed', val2(1));
end    

