function h = ploth(varargin) 
% function h = ploth(varargin)
% plot added to previous axes and
% hold state restored.

% by Magnus Almgren 010220
holdstate = sethold(1); % set hold on
% do the plot
if nargout == 1 % Deliver handle ?
 h = plot(varargin{:});
else
 plot(varargin{:}); % no handle asked for
end
sethold(holdstate); % restore hold state