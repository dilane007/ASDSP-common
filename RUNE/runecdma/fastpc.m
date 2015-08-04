function [pumb, pdmb] = fastpc(pumb, pdmb, sirumb, sirdmb, sirtarget, pmax)
% DESCRIPTION
%  [pumb, pdmb] = fastpc(pumb, pdmb, sirumb, sirdmb, sirtarget, pmax)
%  Fast power control algorithm. Only the uplink is implemented.
% INPUT
%  pumb      -- uplink transmit power matrix [mb <=> mobiles by bases)
%  pdmb      -- qownlink transmit power matrix [mb <=> mobiles by bases)
%  sirumb    -- carrier to interference matrix for the uplink 
%  sirdmb    -- carrier to interference matrix for the downlink 
%  sirtarget -- carrier to interference target  
%  pmax      -- Maximum transmission power
% OUTPUT 
%  pumb      -- uplink transmit power matrix [mb <=> mobiles by bases)
%  pdmb      -- qownlink transmit power matrix [mb <=> mobiles by bases)


% by Magnus Almgren 010125 MA 010515 intro of pmax

% uplink
% pumb is inceased by pumbstep if sirumb is below sirtarger otherwise pumb is deceased
% with the same amount
pumbstep = 1; % power step in dB to be taken at each slot
% maximum ratio combining before decision of up or down
direction = sign(sirtarget - linsum(sirumb,2));
direction(direction==0) = -1; % avoid pitfall at sign(0)
direction(isnan(direction)) = 0; % avoid problems when sirumb is Nan 
pumb = min(pmax, mplus(pumb, pumbstep.*direction)); % make the change


% $Id: fastpc.m,v 1.3 2004/03/11 15:01:11 olav Exp $
