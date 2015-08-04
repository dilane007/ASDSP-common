function h = plotnh(varargin) 
% function h = ploth(varargin)
% previous plot erased before new plot
% is made. Current holdstate is not changed

% by Magnus Almgren 010220
holdstate = sethold(0); % set hold off
% do the plot
if nargout == 1 % Deliver handle ?
 h = plot(varargin{:});
else
 plot(varargin{:}); % no handle asked for
end
sethold(holdstate); % restore hold state