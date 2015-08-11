function z = qformat(x,qpoint)
% <060609> addition bytes; limits
% <060609> limits are 8q8 and 16q16
% <060609> upper limit to 40bits
% <070909> upper limit to 50bits; addition format q extended
% <071709> addition 53q53; meaning q format is double fp
% <071809> addition flexible qformat
% <082209> addition 53.53 as possible parameter
% <090109> addition 16.0, 32.0, 50.0 as possible parameter; 
% <091409> addition 28.22:32.18 
% <170415> addition 24bits -- used not tested 
% <230515> addition 40bits -- used not tested; 24bits are now partially tested 
% <240515> addition 48bits -- used not tested;
% <120815> error corrected 4.04 i.o 4.05(sic!)
%KLUDGE
if (eq(qpoint,5353)) ||(eq(qpoint,53.53)), z=x; return; end; %keep double FP precision
if (eq(qpoint,800)),   z=qbformat(x,0); return;end;   
if (eq(qpoint,1600)),  z=qsformat(x,0); return;end;   
if (eq(qpoint,2400)),  z=qoformat(x,0); return;end;   
if (eq(qpoint,3200)),  z=qlformat(x,0); return;end;   
if (eq(qpoint,4000)),  z=qelformat(x,0); return;end;   
if (eq(qpoint,4800)),  z=qloformat(x,0); return;end;   
if (eq(qpoint,5000)),  z=qeformat(x,0); return;end;   
%
if (gt(qpoint,50)),error('q point must be less or equal to 50');end;
switch(qpoint)
    case{0}, error('q point must be greater than 0');
    %integer have only 4 width:b,s,l and note long long is replaced by extended    
    case{1,2,3,4,5,6,7},    z=qbformat(x,qpoint);   
    case{8,9,10,11,12,13,14,15},    z=qsformat(x,qpoint);   
    case{16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},  z=qlformat(x,qpoint);
    case{32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49},    z=qeformat(x,qpoint);
    %fractionals have 7 width(8,16,24,32,40,48,50); more could be developped    
    case{0.08,1.07,2.06,3.05,4.04,5.03,6.02,7.01},    
         qp=(qpoint-fix(qpoint));   
         z=qbformat(x,round(100*qp));   
    case{0.16,1.15,2.14,3.13,4.12,5.11,6.10,7.09,8.08,...
         9.07,10.06,11.05,12.04,13.03,14.02,15.01},    
         qp=(qpoint-fix(qpoint));   
         z=qsformat(x,round(100*qp));   
    case{0.24,1.23,2.22,3.21,4.20,5.19,6.18,7.17,...
         8.16,9.15,10.14,11.13,12.12,13.11,14.10,15.09,16.08,17.07,...
         18.06,19.05,20.04,21.03,22.02,23.01},    
         qp=(qpoint-fix(qpoint));  
         z=qoformat(x,round(100*qp));   
    case{0.32,1.31,2.30,3.29,4.28,5.27,6.26,7.25,8.24,9.23,10.22,11.21,12.20,13.19,14.18,15.17,...
         16.16,17.15,18.14,19.13,20.12,21.11,22.10,23.09,24.08,25.07,...
         26.06,27.05,28.04,29.03,30.02,31.01},    
         qp=(qpoint-fix(qpoint));   
         z=qlformat(x,round(100*qp));   
    case{0.40,1.39,2.38,3.37,4.36,5.35,6.34,7.33,8.32,9.31,10.30,11.29,12.28,13.27,14.26,15.25,...
         16.24,17.23,18.22,19.21,20.20,21.19,22.18,23.17,24.16,...
         26.14,28.12,30.10,32.08,34.06,36.04,38.02,39.01},    
         qp=(qpoint-fix(qpoint));   
         z=qelformat(x,round(100*qp));   
    case{0.48,1.47,2.46,3.45,4.44,5.43,6.42,7.41,8.40,9.39,10.38,11.37,12.36,13.35,14.34,15.33,...
         16.32,17.31,18.30,19.29,20.28,21.27,22.26,23.25,24.24,...
         30.18,32.16,34.14,36.12,38.10,40.08,42.06,44.04,46.02,47.01},    
         qp=(qpoint-fix(qpoint));   
         z=qloformat(x,round(100*qp));   
    case{0.50,1.49,2.48,3.47,4.46,5.45,6.44,7.43,8.42,9.41,10.40,11.39,12.38,13.37,14.36,15.35,...
         16.34,17.33,18.32,19.31,20.30,21.29,22.28,23.27,24.26,25.25,26.24,27.23,...
         28.22,29.21,30.20,31.19,32.18
         },    
         qp=(qpoint-fix(qpoint));   
         z=qeformat(x,round(100*qp));   
    otherwise
        error('not an implemented qformat (total bits must be 8,16,24,32,50) or syntax incorrect(ex:8.8) use 8.08 instead');
%         if (gt(qpoint,32))
%             z=qeformath(x,qpoint);   
%         else
%             if (gt(qpoint,16))
%                 z=qlformath(x,qpoint);    
%             else
%                 if (gt(qpoint,8))
%                     z=qsformath(x,qpoint);
%                 else
%                     z=qbformath(x,qpoint); 
%                 end;
%             end;
%         end;
end
end
