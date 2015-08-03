function F=imfid(I,J)
% returns the image fidelity between I and J.
% This value is useful to quantitize the distortions on an image.
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
   sumaDif=0;
   for u=1:m
      for v=1:n
         sumaI = sumaI + A(u,v)^2;
         sumaDif = sumaDif + (A(u,v)-B(u,v))^2;
      end
   end
   F=1-(sumaDif/sumaI);  
else 
   error('Images cannot be color')
end
