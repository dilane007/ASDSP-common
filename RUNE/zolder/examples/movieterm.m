function movieterm(sys,sta)

% by Magnus Almgren 010131
for j=1:length(sta.m)
 showterm(sys,sta,sta.m(j))
 pause(.3)
end
