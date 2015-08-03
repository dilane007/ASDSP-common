function S=cq(I,J)
% CQ(I,J) retruns the correlation quality between the images I and J.
% The CQ value is useful to quantitize the distortions on an image.
%% dfm changes: syntax corrector, spanish to english
% Original code (I believe) is by Gabriela Delfino and Fabian Martinez
%  from the Matlab exchange 

%% Code
if (size(I)~=size(J))
   error('Images must have the same size')
end

if (~isrgb(I) && ~isrgb(J))
   [m n] = size(I);
   A=double(I);
   B=double(J);
   sumaI=0;
   sumaProd=0;
   for u=1:m
      for v=1:n
         sumaProd = sumaProd + A(u,v)*B(u,v);
         sumaI=sumaI+A(u,v);
      end
   end
   if (sumaI==0) 
      sumaI=0.0000000001;
   end
   S=sumaProd/sumaI;
else 
   error('Images cannot be color')
end
