function [z w u]= demux13(x,slct) 
 switch(slct)
       case(0), z=x; 
       case(1), w=x; 
       case(2), u=x; 
 end;
 end