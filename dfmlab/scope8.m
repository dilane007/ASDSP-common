function scope8(strusco)
 t=1:length(strusco.ch1);
 plot(t,strusco.ch1,t,strusco.ch2,t,strusco.ch3,t,strusco.ch4,...
     t,strusco.ch5,t,strusco.ch6,t,strusco.ch7,t,strusco.ch8);
 title('8-channel scope');
 legend(strusco.str1,strusco.str2,strusco.str3,strusco.str4,...
       strusco.str5,strusco.str6,strusco.str7,strusco.str8);
end