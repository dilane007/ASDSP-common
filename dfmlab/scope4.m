function scope4(strusco)

t=1:length(strusco.ch1);
plot(t,strusco.ch1,t,strusco.ch2,t,strusco.ch3,t,strusco.ch4);
title('4-channel scope');
legend(strusco.str1,strusco.str2,strusco.str3,strusco.str4);
end