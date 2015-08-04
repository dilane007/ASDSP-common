function holdstate = sethold(state)
% function sethold(state)
% outputs the current hold state and the sets it accordingly 
% to the new state. Without argument it leaves the corrent state
% SEE ALSO hold, ishold
% Try sethold(1), sethold(0), sethold

% by Magnus Allmgren 010220
holdstate = ishold;
if nargin >0
 if state 
  hold('on')
 else
  hold('off')
 end
end