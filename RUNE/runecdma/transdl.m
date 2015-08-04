function [cdb, idb, cidb] = transdl(pdb,gdb,noisedb,reb)
% function [cdb, idb, cidb] = transdl(p,g,noise,reb)
% singleton dimensions will be expanded to fit the other
% INPUT
% pdb -- is the transmit power in dBm with users along the first dimension 
% and bases along the second dimension
%  -inf where links are not used (no power in dBm)
% gdb -- is the gain values in dB.
% noisedb -- is the noisefloor in dB that the receiver cannot escape 
% reb -- is the interference reduction that the receiver will enjoy in own base
% OUTPUT
% cdb -- Carrier power in dBm
% idb -- Interference power in dBm
% cidb -- Carrier to interference ratio in dB
% TRY
% [cdb, idb, cidb] = transdl(zeros(1,1),0,-inf,0) One user one base
% [cdb, idb, cidb] = transdl(zeros(1,2),0,-inf,0) One user in soft handoff to 2 bases
% [cdb, idb, cidb] = transdl(zeros(2,1),0,-inf,0) Two users in one base
% [cdb, idb, cidb] = transdl(zeros(2,1),0,-inf,1) Full orthogonality 

% by Magnus Almgren 010215 revised MA 010515

% individual power components, total power, gain, all in linear scale 

if isempty(pdb) % nothing in nothing out
 cdb  = pdb;
 idb  = pdb;
 cidb = pdb;
 return
end 

% into the linear domain with adjusted sizes  
[p, g] = adjsiza(db2lin(pdb),db2lin(gdb)); % bugfix MA 010515
					   
% Basestation power through the gain matrix
ss =  mprod(sum(p,1),g);                 

% The total power received by the mobile
tss = adjsiza(sum(ss,2), ss) + db2lin(noisedb);

% User transmit power through the gain matrix
c =  p.*g;                                 
                                 					   
% the not desired power compensated for orthogonality factor in own
% bases. Notice that the interference differs from link to link
i = tss - reb*ss - (1-reb)*c;

% back to the log domain
cdb  = lin2db(c);
idb  = lin2db(i);
cidb = lin2db(mdiv(c,i)); % avoid some problems for small i

% $Id: transdl.m,v 1.4 2004/03/15 14:23:39 bogdant Exp $
