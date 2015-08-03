function [z w]= demux12(x,slct) 
 switch(slct)
       case(0), z=x; 
       case(1), w=x; 
 end;
 end