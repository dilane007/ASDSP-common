 function [pumb, pdmb] = terminate(pumb, pdmb, term)
% DESCRIPTION [pumb, pdmb] = terminate(pumb, pdmb, term)
% INPUT
%  pumb --   A powwer uplink matrix with size mobiles by bases 
%  pdmb --   A powwer downlink matrix with size mobiles by bases 
%  term --   A binary vector of the same size as b and k indicating
%            which links that are going to be released.
% OUTPUT
%  pumb --   A powwer uplink matrix with size mobiles by bases 
%  pdmb --   A powwer downlink matrix with size mobiles by bases 

% by Magnus Almgren 000925

if isempty(pumb)
 return   %DFM
end

% NaN indicates not used any more
pumb(term,:) = NaN;
pdmb(term,:) = NaN;
