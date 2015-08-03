function seq = SeqM1(row,cln,gain,rowginc,clnginc)
if (nargin < 5)
  clnginc=0; end 
if (nargin < 4)
  rowginc=0; end 
seq = ones(row,cln)*gain;
for n=1:row
  seq(n,:) = seq(n,:)*rowginc*n;
end;
for n=1:cln
  seq(:,n) = seq(:,n)*clnginc*n;
end;



                                                                                                      




