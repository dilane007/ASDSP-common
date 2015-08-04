function [cdb, idb, cidb] = transul(pdb, gdb, noisedb)
% DESCRIPTION
% [cdb, idb, cidb] = transul(pdb, gdb, noisedb)
% Calculate the uplink carrier, interference and C/I.
% All matrices are assumed to be of the same size and in dB.
% Singleton dimensions will be expanded to fit the other
% arguments if necessary. Dimensions: connections by bases
% INPUT
% pdb --    Transmit power in dBm with users along the first dimension 
%           and bases along the second dimension. Set to
%           -inf where links are not used (zero power in dBm)
% gdb --    Gain values in dB.
% noisedb -- Noisefloor in dBm that the receiver cannot escape
%
% OUTPUT
% cdb --    Carrier power for the uplink in dBm
% idb --    Interference power for the uplink in dBm
% cidb --   C/I for the uplink in dB
%
% TRY 
% transul(zeros(3,2),0,-103)
% SEE ALSO
% transdl

% by Magnus Almgren 010515

if isempty(pdb) % nothing in nothing out
 cdb  = pdb;
 idb  = pdb;
 cidb = pdb;
 return
end 

% into the linear domain with adjusted sizes  
[p, ptot, g] = adjsiza(db2lin(pdb), db2lin(max(pdb,[],2)), db2lin(gdb));

% Mobile power through the gain matrix  
ss  = ptot .* g;

% The total power received by the base station
tss = adjsiza(sum(ss,1),ss);

% User transmit power through the gain matrix
c  = p .* g;

% The received interference 
i = tss - c + db2lin(noisedb);

% back to the log domain
cdb  = lin2db(c);
idb  = lin2db(i);
cidb = lin2db(mdiv(c,i)); % avoid some problems for small i

% $Id: transul.m,v 1.5 2004/03/15 14:23:39 bogdant Exp $
