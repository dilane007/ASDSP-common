function  [pumb, pdmb] = handoffc(pumb, pdmb, g, homargin, pinit);
% DESCRIPTION [pumb, pdmb] = handoffc(pumb, pdmb, g, homargin, pinit)
%
% Implements an ideal handover algorithm for CDMA. It assumes that
% the uplink power matrix contains NaN-s for all the new links. The
% new mobiles are initialised with an initial power. The new links
% (added in softhandover) to old mobiles are set to the maximum
% previous power. If a mobile is not linked to a base station, this
% is indicated by a value of -Inf in the power matrix.
%
% INPUT
%  pumb     --  (m*b) power matrix for uplink; NaN for new mobiles [dB]
%  pdmb     --  (m*b) power matrix for downlink [dB]
%  g        --  (m*b) Gain matrix with gain values in dB.
%  homargin --  Standard deviation of the noise added to the
%               gain matrix when base selection is made. [dB]
%  pinit --     Init power at link setup [dB]
%
% OUTPUT
%  pumb    -- (m*b) pinit for links of new mobiles 
%                   -Inf  if no connection between mobile and bs
%                   the current power otherwise
%  pdmb    -- (m*b) power matrix for downlink. Same rules as for uplink
%

% by Magnus Almgren 000925 010123

if isempty(pumb)   % the empty case
 return 
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

% $Id: handoffc.m,v 1.1 2004/03/15 09:31:04 bogdant Exp $
