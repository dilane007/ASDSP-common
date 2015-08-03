function [z w u t]= demux14(x,slct) 
 switch(slct)
       case(0), z=x; 
       case(1), w=x; 
       case(2), u=x; 
       case(3), t=x; 
 end;
 end