function [c, i, ci] = transul(p,g,noise)
% function [c, i, ci] = transul(p,g,noise)
% all matrices are assumed to be of the same size and in dB
% singleton dimensions will be expanded to fit the other
% arguments if necessary. Dimensions: connections by bases
% p is the transmit power in dBm with base along the 2nd dimension
% connections along the 1st dimension (rows). -inf where links are not used
% glin is the corresponding gain values in linear measures
% ci do not span the 2nd dimension so it not per base
% Try examples like transul(zeros(3,2),0,-103)

% by Magnus Almgren 990703 010122

% individual power components, total power, gain, all in linear scale 

if isempty(p) % nothing in nothing out
 c = p;
 i = p;
 ci = p;
 return; %DFM
end

%[plin, splin, glin] = adjsiza(db2lin(p), db2lin(max(p,[],2)), db2lin(g));
plin = db2lin(p); 
splin = repmat(db2lin(max(p,[],2)),[1 size(plin,2)]); 
glin = db2lin(g); 
c  = glin.* plin; % desired received power  
ss  = glin.* splin; % total power at each receiver from each transmitter
tss = adjsiza(sum(ss,1),ss); % total power at the receiver 
i = tss - ss + db2lin(noise); % received interferenceci = lin2db(c) - lin2db(max(i,0)); % SIR value matrix
% all in dB
warning off % avoid divide by zero warning
ci = lin2db(c./i.*(plin>0)); % 
warning on
c  = lin2db(c);
i  = lin2db(i);
