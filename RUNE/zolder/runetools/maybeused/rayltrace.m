function z = rayltrace(dxperlambda, siz)
if ~exist('dxperlambda','var')
 dxperlambda = 0.07; % m/s
end
if length(dxperlambda)==1
 if ~exist('siz','var')
  siz = 256*ones(size(dxperlambda));
 end
 v = mprod(dxperlambda(:),(1:siz))*2*pi;
 r = abs(v-mean(v(:)));
 htau = r.^-0.25.*besselj(0.25,r);
 z = ifft(fft(irandn(size(htau))).*fft(htau))...
  /(norm(htau)*sqrt(2));
elseif length(dxperlambda)==2
 if ~exist('siz','var')
  siz = 64*ones(size(dxperlambda));
 end
 v1 = dxperlambda(1)*(1:siz(1  ))*2*pi;
 v2 = dxperlambda(2)*(1:siz(end))*2*pi;
 r = abs(mplus(v1-mean(v1), v2.'-mean(v2)));
 htau = r.^-0.25.*besselj(0.25,r);
 z = mdiv(ifft2(fft2(irandn(size(htau))).*fft2(htau))...
  ,sqrt(sum(sum(abs(htau).^2,2),1))*sqrt(2));
end
meshc(lin2db(abs(z).^2))
break
hold off
plot(z)
hold on
plot(z,'r.')
plot(0,0,'*')
hold off