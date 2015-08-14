%common\dfmlab\print_manager.m
%1.1 <11jan2007> add surfx, surf4
%1.2 <29jan2007> add many actors from print_managerMODEM.m
%1.3 <05feb2007> add ff3
%1.4 <04Mar2007> cosmetics 
%1.5 <20Mar2007> add pxz 
%1.6 <21May2007> add pxz1; changed pxz to pxz0; suppressed pxz2
%1.7 <12Apr2009> add pzg1; name is gold (not golden)
%2.1 <05May2009> add message for constants
%3.1 <05Aug2015> [freem] cosmetics and better style 
%3.2 <08Aug2015> pxz4: a better plotter  
%3.3 <12Aug2015> small improv.  
%=====================================
%--CONSTANTS
asep    = '==================================================\n';
ablock  = '############################################################\n';

%--CODE
cc = isempty(verbose);
if (cc) , verbose=0; end;
if (verbose >=2), fprintf(OFP,'[PRINTMAN]printactor is %s \n',printactor);end;
cc = isempty(verbo);
if (cc) , verbo.printman=0; end;
if (verbo.printman >=1), fprintf(OFP,'[PRINTMAN]printactor is %s \n',printactor);end;
switch(printactor)
%============== FPRINTF =======================
   case{'nill'}
   case {'eol'}  ,  fprintf(OFP,'\n');
   case {'CR'}    , fprintf(OFP,'\n');
   case {'ok'}    , fprintf(OFP,'no error \n');
   case {'alldone'} , fprintf(OFP,'all tests passed \n');
   case {'wrong'}   , fprintf(OFP,'WRONG expected result \n');
   case {'separe'}  , fprintf(OFP,asep);
   case {'tesep'}  ,  for ii=1:3, fprintf(OFP,ablock);end;
   case {'alldot'}  , fprintf(OFP,'.\n');
   case {'alldash'}  , fprintf(OFP,'-\n');
   case {'dotline'}  , fprintf(OFP,'.');
   case {'dashline'}  , fprintf(OFP,'-');
%============== DISP =======================
   case{'in'},        disp(x);
    case{'x'},        disp(x);
    case{'z'},        disp(z);
    case{'xz'},       disp(x);disp(z);
    case{'xw'},       disp(x);disp(w);
    case{'zg1'},      disp(z);disp(gold);
    case{'zg'},       disp(z);disp(goldenz);
    case{'w'},        disp(w);disp(goldenw);
    case{'wg'},       disp(w);disp(goldenw);
    case{'out'},      disp(z);disp(w);
%============== PLOT =======================
    case{'pz'},        plot(x,z);    
    case{'pw'},        plot(x,w);
    case{'pzw'},       plot(x,z,x,w);
    case{'pxz1'},
        t=1:length(x);
        figure; 
        plot(t,x,'b-',t,z,'r-');
        legend('Input','Output');    
    case{'pxz2'}
        figure; 
        plot(t,x,'b-',t,z,'r-');
        legend('Original signal','Recovered signal');    
    case{'pxz3'}
        subplot(2,1,1);plot(x); 
        subplot(2,1,2);plot(z); 
    case{'pxz4'}
        t=1:length(x);
        figure;
        plot(t,x,);   hold on;    plot(t,z,'r-');    grid on;
        legend('Input Data','Filtered Data','Location','NorthWest')
        title('BB DSPFUN- FILTER BB')    
    case{'piq'}
        subplot(2,1,1);plot(t,Iphi);title('In phase');
        subplot(2,1,2);plot(t,Qphi);title('Quad phase');
    case{'pssb'}
        % Plot results to show that the curves overlap.
        figure; 
        plot(t,z,'r-',t,w,'g--');
        legend('Demodulation of upper sideband','Demodulation of lower sideband')
%============== SURF =======================
    case{'surfx'},        figure(1); surf(x);
    case{'surfz'},        figure(1); surf(z);
    case{'surf'}
        figure(1); surf(x);
        figure(2); surf(z);
        figure(3); surf(w);
    case{'surf4'}
        figure(1); surf(prin1);
        figure(2); surf(prin2);
        figure(3); surf(prin3);
        figure(4); surf(prin4);
    case{'surf6'}
        figure(1); surf(prin1);
        figure(2); surf(prin2);
        figure(3); surf(prin3);
        figure(4); surf(prin4);
        figure(5); surf(prin5);
        figure(6); surf(prin6);
    case{'surfft'}
        [nrow ncln]=size(z);
        [a b]=meshgrid(1:nrow,1:ncln);
        surf(a,b,z);
    %============== MESH =======================
    case{'mesh'}
        figure(1); mesh(x);
        figure(2); mesh(z);
        figure(3); mesh(w);
%============== SCATTER =======================
    case{'scat1'}
        % See how scaling affects constellation.
        h = scatterplot(xconstel,1,0,'ro'); % Unscaled constellation
        hold on; % Next plot will be in same figure window.
        scatterplot(xconstel*z,1,0,'bx',h); % Scaled constellation
        hold off;
    case{'scatqp'}
    % Find indices of points that mapped to the digits 0 and 3.
        red  = find(z==0);
        blue = find(z==3);
        % Plot points corresponding to 0 and 3.
        h = scatterplot(x(red,:),1,0,'r.'); hold on
        scatterplot(x(blue,:),1,0,'b.',h);
        legend('Points corresponding to 0','Points corresponding to 3');
        hold off
%============== EYE =======================
    case{'eye1'}
         z = awgn(z,30,'measured');
         eyediagram(z,16);
%============== FFTER =======================
    case{'fft0'}
        zlen  = length(z);
        freq  = Fs/2*linspace(0,1,zlen/2);
        ampli = 2*abs(z(1:NFFT/2)/L); 
        plot(freq,ampli); 
        title('Amplitude Spectrum of z(t)')
        xlabel('Frequency (Hz)')
        ylabel('|Z(f)|')
    case{'fft1'}
        zlen = length(z);
        freq = -Fs/2 : Fs/zlen : Fs/2 - Fs/zlen;
        ampli = 10*log10(fftshift(abs(fft(z))));
        plot(freq,ampli);
    case{'fft2'}
        % Compute spectra of both modulated signals.
        zdouble   = fft(z);
        zdouble   = abs(zdouble(1:length(zdouble)/2+1));
        frqdouble = (0:length(zdouble)-1)*Fs/length(zdouble)/2;
        zsingle   = fft(w);
        zsingle   = abs(zsingle(1:length(zsingle)/2+1));
        frqsingle = (0:length(zsingle)-1)*Fs/length(zsingle)/2;
        % Plot spectra of both modulated signals.
        figure;
        subplot(2,1,1); plot(frqdouble,zdouble);
        title('Spectrum of double-sideband signal');
        subplot(2,1,2); plot(frqsingle,zsingle);
        title('Spectrum of single-sideband signal');
    otherwise
    fprintf(OFP,'[PRINTMAN] printactor %s is UNKNOWN ### \n',printactor)
end;
