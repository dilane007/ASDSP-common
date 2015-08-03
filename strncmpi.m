%[DFM] z= strncmpi(s1, s2, n) Compare strings(1:n) ignoring case, 
%% z=1 if same, and 0 otherwise.
% type, shape, range checking: none
function z = strncmpi(s1, s2, n)
  z= strncmp(upper(s1),upper(s2),n);
end

