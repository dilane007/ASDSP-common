%SNR.m
function S=snr(I,J)
% SNR(I,J) returns the signal to noise ratio between I and J (dB).
% I is the original image and J is a modified version of I. 
% The SNR value is useful to calculate the distortions on an image.
%% dfm changes: syntax corrector, spanish to english
% Original code (I believe) is by Gabriela Delfino and Fabian Martinez
%  from the Matlab exchange 

%% Code
if (size(I)~=size(J))
   error('Images must have the same size')
end
if (isrgb(I))
    aux=RGBtoYIQ(I);
    A=double(aux(:,:,1));
    size(A);
    aux=RGBtoYIQ(J);
    B=double(aux(:,:,1));	
else
   A=double(I);
   B=double(J);
end
[m n] = size(A);
sumaI=0;
sumaDif=0;

for u=1:m
     for v=1:n
         sumaI = sumaI + A(u,v)^2;
         sumaDif = sumaDif + (A(u,v)-B(u,v))^2;
     end
end
if (sumaDif==0) 
    sumaDif=1;
end
S=sumaI/sumaDif;
S=10*log10(S);
