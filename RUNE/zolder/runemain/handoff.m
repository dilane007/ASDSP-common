function  [pumb, pdmb] = handoff(pumb, pdmb, g, homargin, pinit);
% DESCRIPTION [pumb, pdmb] = handoff(pumb, pdmb, g, homargin, pinit)
% INPUT
%  g --         Gain matrix with gain values in dB. Size is #links by #bases
%  homargin --  Standard deviation of the noise added to the
%               gain matrix when base selection is made. [dB]
%  pinit --     Init power at link setup
% OUTPUT
% TRY 

% by Magnus Almgren 000925 010123

if isempty(pumb)   % the empty case
 return ; %DFM  
end

newu = isnan(pumb(:,1)); % Do only act on already assigned channels.
m = (1:size(g,1))'; % make an index to each row in the gain matrix
bind  = mplus(homargin,g,-max(g,[],2))>=0;

pumb  = lin2db(mprod(~newu, bind, db2lin(max(pumb,[],2))));
pumb(logical(mprod(newu,bind))) = pinit;
pumb(isnan(pumb)) = -Inf;

pdmb  = lin2db(mprod(~newu, bind, db2lin(max(pdmb,[],2))));
pdmb(logical(mprod(newu,bind))) = pinit;
pdmb(isnan(pdmb)) = -Inf;
