function [cdb, idb, cidb] = transdl(pdb,gdb,noisedb,reb)
% function [ci] = transdl(p,g,noise,reb)
% singleton dimensions will be expanded to fit the other
% pdb is the transmit power in dBm with users along the first dimesion 
% and bases along the second dimension
%  -inf where links are not used (no power in dBm)
% glin is the corresponding gain values in linear measures.
% noiselin is the noisefloor that the receiver cannot escape 
% reb is the interference reduction that the receiver will enjoy in own base
% Try 
% [cdb, idb, cidb] = transdl(zeros(1,1),0,-inf,0) One user one base
% [cdb, idb, cidb] = transdl(zeros(1,2),0,-inf,0) One user in soft handoff to 2 bases
% [cdb, idb, cidb] = transdl(zeros(2,1),0,-inf,0) Two users in one base
% [cdb, idb, cidb] = transdl(zeros(2,1),0,-inf,1) Full orthogonality 

% by Magnus Almgren 010215

% individual power components, total power, gain, all in linear scale 

if isempty(pdb) % nothing in nothing out
 cdb = pdb;
 idb = pdb;
 cidb = pdb;
 return; %DFM
end 
% into the linear domain with adjusted sizes  
[p, g] = adjsiza(db2lin(gdb),db2lin(pdb));
C =  mprod(sum(p,1),g); % Basestation power trough the gain matrix
c =  p.*g; % User transmit power trough the gain matrix
% the not desired power compensated for orthogonality factor in own bases
i = adjsiza(sum((C-c).*(1-reb.*(c>0)) + db2lin(noisedb),2),c);
% back to the log domain
idb = lin2db(i);
cdb  = lin2db(c);
cidb =lin2db(mdiv(c,i)); % avoid some problems for small i
