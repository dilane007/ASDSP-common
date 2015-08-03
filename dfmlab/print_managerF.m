%ARITI\ROUNDER\print_managerF.m
%=====================================================
function print_managerF(printactor,bufsize,buf1,buf2,buf3,buf4,buf5,buf6)

global verbose 
global OFP
%--CONSTANTS
form1 ='%8d \n';
form31 ='%10.4f %4.1f %4.1f \n';
form32 ='%10.4f %10.4f %10.4f \n';
form41 ='%10.4f %4.1f %4.1f %4.1f \n';
form42 ='%10.4f %10.4f %10.4f %10.4f \n';
form52 ='%10.4f %10.4f %10.4f %10.4f %10.4f \n';
formc2 ='%c%c \n';
formc4 ='%c%c%c%c \n';
formc8 = '%c%c%c%c%c%c%c%c \n';
formc16 ='%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c \n';
form11L ='%16.10f %16.10f \n';
form32L ='%16.10f %16.10f %16.10f \n';
form42L ='%16.10f %16.10f %16.10f %16.10f \n';

if (verbose ==1 || verbose ==10) 
 disp(['[PRINTMAN]........' printactor] );end; 

%----------------------
if strcmp(printactor,'print11L'),    printactor='print11'; form11=form11L; end;
if strcmp(printactor,'print32L'),    printactor='print32'; form32=form32L; end;
if strcmp(printactor,'print42L'),    printactor='print42'; form42=form42L; end;
%----------------------
switch printactor
   case {'print1'}      
      for j=1:bufsize 
        fprintf(OFP,form1,buf1(j)) ;end
   case {'print11'}      
      fprintf(OFP,'\t input          output \n');
      for j=1:bufsize 
        fprintf(OFP,form11,buf1(j), buf2(j)) ;end
   case {'print31'}      
      for j=1:bufsize 
        fprintf(OFP,form31,buf1(j), buf2(j), buf3(j)) ;end
   case {'print32'}      
      for j=1:bufsize 
        fprintf(OFP,form32,buf1(j), buf2(j), buf3(j)) ;end
   case {'print41'}      
      for j=1:bufsize 
        fprintf(OFP,form41,buf1(j), buf2(j), buf3(j), buf4(j)) ;end
   case {'print42'}      
      for j=1:bufsize 
        fprintf(OFP,form42,buf1(j), buf2(j), buf3(j), buf4(j)) ;end
   case {'print52'}      
      for j=1:bufsize 
        fprintf(OFP,form52,buf1(j), buf2(j), buf3(j), buf4(j), buf5(j)) ;end
   case {'print62'}      
      for j=1:bufsize 
        fprintf(OFP,form52,buf1(j), buf2(j), buf3(j), buf4(j), buf5(j), buf6(j)) ;end
   case {'printc2'}      
      for j=1:bufsize 
        fprintf(OFP,formc2,buf1(j,1),buf1(j,2)) ;end
   case {'printc4'}      
      for j=1:bufsize 
        fprintf(OFP,formc4,buf1(j,1),buf1(j,2),buf1(j,3),buf1(j,4)) ;end
   case {'printc8'}      
      for j=1:bufsize 
        fprintf(OFP,formc8,buf1(j,1),buf1(j,2),buf1(j,3),buf1(j,4), ...
            buf1(j,5),buf1(j,6),buf1(j,7),buf1(j,8));
      end;
   case {'printc16'}      
      for j=1:bufsize 
        fprintf(OFP,formc16,buf1(j,1),buf1(j,2),buf1(j,3),buf1(j,4), ...
            buf1(j,5),buf1(j,6),buf1(j,7),buf1(j,8), ...
            buf1(j,9),buf1(j,10),buf1(j,11),buf1(j,12), ...
            buf1(j,13),buf1(j,14),buf1(j,15),buf1(j,16));
      end;
    otherwise
        disp('print actor unknown')
end


