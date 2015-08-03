% [z status]= VMAX(x,y,len,topo,fused)
% first shot at matlab max()    
% x,y,z are row vectors
% topo=input topology  1=1 operand    2=2 operands 
% fused=output type    1=scalar    2=vector 
function [zvec status]=vmax(xvec,yvec,len,topo,fused);
 IMPLM=1;
 OFP=1;
 MLABIDX=1;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 status=int8(0);   
 if (nargin<5) fused=1;    status=status+16; end;
 if (nargin<4) topo=1;     status=status+8; end;
 if (nargin<3) len=2;      status=status+4; end;
 if (nargin<2) yvec=[0 0]; status=status+2; end;
 if (nargin<1) xvec=[0 0]; status=status+1; end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 eve= fix(len/2)*2 == len
 switch(topo)
     case (1)
         xin=[xvec(1:len) -inf] %pad with -infinity
         if eve  
          x=xin(1:2:len-1);
          y=xin(2:2:len);
         else
          x=xin(1:2:len)
          y=xin(2:2:len+1)
          status=status-128; 
         end;
     case (2)
         x=xvec(1:len);
         y=yvec(1:len);
     otherwise
         x=0; y=0;
         status=status+100; 
 end
%    
 z=max21(x,y); 
%        
 if fused==1, zvec=max11(z); else zvec=z; end;
            
end

