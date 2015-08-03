function S=sc(I,J)
% SC(I,J) returns the relation between the structural contents of I 
% and J.
% The SC value is useful to quantitize the distortions on an image.
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
   sumaICuad=0;
   sumaJCuad=0;
   for u=1:m
      for v=1:n
         sumaJCuad = sumaJCuad + B(u,v)*B(u,v);
         sumaICuad=  sumaICuad + A(u,v)*A(u,v);
      end
   end
   if (sumaJCuad==0) 
      sumaJCuad=1;
   end
   S=sumaICuad/sumaJCuad;
else 
  error('Images cannot be color')
end

