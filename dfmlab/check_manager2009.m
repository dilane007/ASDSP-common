%common\check_manager.m 
%1.2 <04Mar2007> cosmetics  
%1.4 <24Apr2007> repair sync23, sync45  
%1.5 <24Apr2007> addition checkactor sumabs,sumrel  
%1.6 <30mar2009> cosmetics  
%1.7 <30mar2009> creation test empty for default maxerr;   
%  WARNING! cmp and sumabs,sumrel are not identical
% cmp        differ= abs(sum(chin0-chin1)) ;
% sumabs     differ= sum(abs(chin0-chin1)) ;
%----------------------------------------------------

stch01='Nbr of errors =%d \n';
stch02='Nbr of errors for %s =%d \n';
stch03='WOOOW! did you generate the GOLD?';
stch11='The max. allowed error is = %8.4f \n';
strok= 'CHECKER WITHIN LIMITS ';

cc = isempty(maxerr);
if (cc) , maxerr= power(10,-12);end;
fprintf(ofp,'checkactor is %s \n',checkactor)
switch(checkactor)
    case('genegold')
        gold=z;
    case('showgold')
        disp(gold);
    case('cmpgold')
        differ = abs(sum(gold-z));  
        if differ > maxerr ,  disp(stch03); else disp(strok);end
    case('cmp') 
        differ= abs(sum(chin0-chin1)) ;
        if differ > chin2 
        disp('WOOOW'); else disp(strok);end
    case('sumabs')
        differ= sum(abs(chin0-chin1)) ;
        if differ > chin2 
        disp('WOOOW'); else disp(strok);end
    case('sumrel')
        differ= sum((chin0-chin1)./chin0) ;
        if differ > chin2 
        disp('WOOOW'); else disp(strok);end
    case('sync')
        differ= sum(abs(chin0-chin1)) ;
        if differ > maxerr 
           disp('WOOOW'); else disp(strok);end
    case('sync23')
        differ= sum(abs(chin2-chin3)) ;
        if differ > maxerr 
           disp('WOOOW'); else disp(strok);end
    case('sync45')
        differ= sum(abs(chin4-chin5)) ;
        if differ > maxerr 
           disp('WOOOW'); else disp(strok);end
    case('getbounds')
        bounds= max(abs(chin0-chin1)) ;
    case('report')
        fprintf(ofp,'maxerr= %g , differ =%g  bounds=%g \n',maxerr,differ,bounds);
    case('reporter')
        fprintf(ofp,'REPORTING: maxerr= %g , differ =%g  \n',maxerr,differ);
    case('nill')
        
    otherwise
    disp('checkactor unknown');
end% end switch

