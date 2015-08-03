function Y=rgb2yiq(I)
% RGB to YIQ representation
%% dfm changes: syntax corrector, spanish to english
% Original code (I believe) is by Gabriela Delfino and Fabian Martinez
%  from the Matlab exchange 

%% Code
 if (~isrgb(I))
    error ('image must be RGB')
 end

matConv= [0.299  0.587  0.114
    	    0.596 -0.275 -0.321
	    0.212 -0.523  0.311];
RGBtoY=matConv(1,:);
RGBtoI=matConv(2,:);
RGBtoQ=matConv(3,:);

RenI=double(I(:,:,1));
GenI=double(I(:,:,2));
BenI=double(I(:,:,3));

Y=zeros(size(I));
Y(:,:,1)=RGBtoY(1)*RenI + RGBtoY(2)*GenI + RGBtoY(3)*BenI;
Y(:,:,2)=RGBtoI(1)*RenI + RGBtoI(2)*GenI + RGBtoI(3)*BenI;
Y(:,:,3)=RGBtoQ(1)*RenI + RGBtoQ(2)*GenI + RGBtoQ(3)*BenI;

