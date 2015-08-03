function z = qsformath(x,qpoint)
%covers from 
% 1q15..1q8
% 2q14..2q7
% 3q13..3q6
% ..
% 8q8..8q1
% 9q7..9q0
% ..
% 14q2..14q0
% 15q1..15q0
    t =int16(round(x*power(2,qpoint)));
    z= double(t)/(power(2,qpoint)); 
end
