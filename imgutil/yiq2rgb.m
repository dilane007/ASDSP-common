function I=YIQtoRGB(Y)
% YIQtoRGB to RGB representation
%% dfm changes: syntax corrector, spanish to english
% Original code (I believe) is by Gabriela Delfino and Fabian Martinez
%  from the Matlab exchange 

%% Code

invmatConv = [1.0   0.9557   0.6199
     		  1.0  -0.2716  -0.6469
     		  1.0  -1.1082   1.7051];

YIQtoR=invmatConv(1,:);
YIQtoG=invmatConv(2,:);
YIQtoB=invmatConv(3,:);

YenIm=double(Y(:,:,1));
IenIm=double(Y(:,:,2));
QenIm=double(Y(:,:,3));

I=zeros(size(Y));
I(:,:,1)= YIQtoR(1)*YenIm + YIQtoR(2)*IenIm + YIQtoR(3)*QenIm;
I(:,:,2)= YIQtoG(1)*YenIm + YIQtoG(2)*IenIm + YIQtoG(3)*QenIm;
I(:,:,3)= YIQtoB(1)*YenIm + YIQtoB(2)*IenIm + YIQtoB(3)*QenIm;
