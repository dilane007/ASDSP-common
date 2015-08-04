function [raylmap, sqfs] = creraylangmap(seed,angmean,angsig,N,M,rv,lambda,nlayer)
% DESCRIPTION
% [raylmap, sqfs] = creraylangmap(seed,angmean,angsig,N,M,rv,lambda,nlayer)
%  Generates a raylegh fading map in two dimensions. The result can also be a stack of independent maps. 
%  Default it is assumed that sources sources are uniformly spread around a sink. See Jakes model.
%  Also maps with non unform angular distributions can be generated.
% INPUT
%  seed --    Seed value to the random generator. Defaults to 1   
%  angmean -- Angle towards the cluster od sources. Defaults to pi/2
%  angsig --  Angle spread of sources. Defaults to Inf <=> Uniform
%             distribution
%  N --       Number of samples in the fft. Defaults to 32.
%  M --       Oversampling factor in ifft. Makes the map smooth. Defaults to 16.
%  rv --      Vectors that span the map. Defaults to [1 i]*N/2 wavelenths
%  lambda --  Vawelength. Defaults 0.15 meter 
%  nlayer --  Number of independent maps. Defaults to 1 
% OUTPUT
%  raylmap -- A complex two dimensional matrix (the map) of size N*M by N*M
%             If nlayer is greater than 1 raylmap is three dimensional
%  sqfs --    square root of the phase spectrum 
% SEE ALSO
% TRY
%  r = creraylangmap;
%  mesh(-lin2db(abs(r))*2)
%  contour(-lin2db(abs(r))*2)
%  plot(r(:,1:2),'.-')
%  axis equal

% by Magnus ALmgren 031027
%
%  Doppler spectrum is defined in the frequency domain given a certain speed.
%  The maximum observed frequency in the spectrum can be denoted as fm.
%  ds = sqrt(1-(f/fm)^2), abs(f)<=fm and zero otherwise 
%  A more fundamental spectrum is achieved if the spectrum is normalized by 
%  this speed. 
%  The phase spectrum
%  fs = sqrt(1-(fi/2/pi)^2), abs(fi/2/pi)<=1 and zero otherwise 
%  Corresponding operation is performed on the space time corellation function.
%  Time is in this case multiplied by the speed and will thus translate into
%  position.
%  This function is denoted space correlation function scf
%  scf = ifft(fs);
%  The resulting transform pair is now positon - phase
%  rather than time - frequency 
%  In a traditional setting all sources generating the "doppler spectrum it is
%  assumed that the sources are spread uniformly in angle. A more elaborate model
%  is used in this case where the sources are spread as
%  afs  = exp(-(angle/2/sigma)^2) 
%  multiplied with some normalisation constant.
%  The size of the side of the map is N/2 wavelengths.  

% Set default values to inputs if they not were present
setifnotexistorempty('seed',2); % seed for the generated map
setifnotexistorempty('angmean',pi/2); % angle towards cluster
setifnotexistorempty('angsig',inf); % angular standard deviation of sources
setifnotexistorempty('N',2.^5); %  Number of samples in phase spectrum
setifnotexistorempty('M',2.^4); % Oversampling for the ifft. Makes the map smooth
setifnotexistorempty('rv','[1 exp(i*2*pi/3)]'); % Mapsize
setifnotexistorempty('lambda',0.15); % Lambda [m]
setifnotexistorempty('nlayer',2); % Number of independent map (3rd dimension of raylmap)  

fft2n = inline('fft(fft(s,N,1),N,2)','s','N'); % two dimensional dft
ifft2n = inline('ifft(ifft(s,N,1),N,2)','s','N'); % two dimensional inverse dft

oseed = setseed(seed); % set seed

% ld2 -- Complex positions in a 2-Dim grid [-1 1 -1 1] TRY plot(ld2,'.')
ld = linspace(-1,1,N+1);
ld2 = mplus(rv(1)*ld(2:end),rv(2)*ld(2:end)'); 

% Normalisation of fs and afs are not necessary. Normalisation is made in
% the very end this routine
% fs -- phase spectrum from angular uniformly spread sources.
fs = (1-abs(ld2/lambda).^2).^(-1/2); 
fs(abs(ld2)>=lambda) = 0;  

% Angular part of the spectrum.
afs = exp(-sqrt(2)*abs((angmean-angle(ld2))/angsig));

% Convolute random complex spatial noise with the square root of the
% space correlation function. The convolution can be performed as a
% multiplication in the phase domain instead.
% fft(phase spectrun) <=> space correlation function
% raylmap is calculated as 
% conv(irandn,sqrt(scf)) <=> ifft(fft(irandn).*fft(ifft(sqrt(fs.*afs)));  
csn = irandn([size(fs) nlayer]); % complex 3 dimensional spatial noise
sqfs = sqrt(fs.*afs); % Into amplitude
raylmap = ifft2n(mprod(fft2(csn),sqfs),N*M); % Convolute

% Normalize map to unit power gain
raylmap = raylmap/std(raylmap(:)); 

% reset seed to its original value
setseed(oseed);

% mesh(abs(fftshift(fft2n(sqrt(fs),N*M))))
% mesh(lin2db(abs(fftshift(fft2n(sqrt(fs),N*M)))))
% mesh(-lin2db(abs(raylmap))*2)
% contour(-lin2db(abs(raylmap(:,:,1)))*2)
% plot(raylmap(:,1:2),'.-')
% hist(abs(raylmap(:)),100)
% axis equal
% $Id: creraylangmap.m,v 1.2 2004/03/11 15:01:31 olav Exp $
