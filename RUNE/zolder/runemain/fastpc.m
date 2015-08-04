function [pumb, pdmb] = fastpc(pumb, pdmb, sirumb, sirdmb, sirtarget)
% function [pumb, pdmb] = fastpc(pumb, pdmb, sirumb, sirdmb, sirtarget)
% pumb -- uplink transmit power matrix [mb <=> mobiles by bases)
% sirumb -- carrier to interference matrix 
% sirtarget -- carrier to interference target  
% uplink power control only

% by Magnus Almgren 010125

% uplink
% pumb is inceased by pumbstep if sirumb is below sirtarger otherwise pumb is deceased
% with the same amount
pumbstep = 1; % power step in dB to be taken at each slot
% maximum ratio combining before decision of up or down
direction = sign(sirtarget - linsum(sirumb,2));
direction(direction==0) = -1; % avoid pitfall at sign(0)
direction(isnan(direction)) = 0; % avoid problems when sirumb is Nan 
pumb = mplus(pumb, pumbstep.*direction); % make the change
