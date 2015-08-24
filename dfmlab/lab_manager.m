% dfmlab\lab_manager.m

% inner wave= sum of out of phase harmonics; outter wave = hat shape (genactor= 'hat1')
% outshaped wave = harmonics not in phase  (genactor= 'outshaped')
% triangular wave  (genactor='triwave')
% 3rd harmonics wave(genactor= 'confitest1')
% plot a wave (genactor= 'confitest0')

%% ================================================================
%% genactor - hardcoded parameters
%% ================================================================
LOG_MANAGER='NO';% {NO,SCOPE,FFTER,PHASE}
BEG=1;
LAST=11; %must be odd harmonics
fprintf(OFP,'-- [GENE] entering gene=%s ---------------------\n',genactor);
fprintf(OFP,'-- [GENE] LOG_MANAGER=%s ---------------------\n',LOG_MANAGER);

%% ================================================================
%% IMPLEMENTATION
%% ================================================================
% inner wave= sum of out of phase harmonics; outter wave = hat shape 
if strcmp(genactor,'hat1')
    t=[0:0.05:10*pi];
    sign=1;
    z=0;
    for ii=BEG:2:LAST
    %tests
        x=ii;
        A= sign /(x*x);
        t = t+ (ii-1)*0.1;%%added phase for each frequency
        gene= A*sin(x*t);
        sign=-sign;
        z = z+gene;
    end;
    z = 8/(pi*pi)*z;% dont forget normalising constant
    z= z .* sin(0.1*t);
fprintf(OFP,'-- [GENE] leaving gene=%s ---------------------------\n',genactor);
end

% outshaped wave = harmonics not in phase
if strcmp(genactor,'outshaped')
    t=[0:0.05:10*pi];
    sign=1;
    z=0;
    for ii=BEG:2:LAST
    %tests
        x=ii;
        A= sign /(x*x);
        t = t+ (ii-1)*0.1;%%added phase for each frequency
        gene= A*sin(x*t);
        sign=-sign;
        z = z+gene;
    end;
    z = 8/(pi*pi)*z;% dont forget normalising constant
end

% triangular wave
if strcmp(genactor,'triwave')
    BEG=1
    LAST=23 %must be odd harmonics
    t=[0:0.05:10*pi];
    sign=1;
    z=0;
    for ii=BEG:2:LAST
        x=ii;
        A= sign /(x*x);
        gene= A*sin(x.*t);
        sign=-sign;
        z = z+gene;
    end;
    z = 8/(pi*pi)*z;% dont forget normalising constant
    if strcmp(LOG_MANAGER,'FFTER')
        zr=real(fft(z));
        zi=imag(fft(z));
        zf= log(sqrt(zr.*zr + zi.*zi));
        tt=1:100;
        plot(tt,zf(tt));
    end;
    if strcmp(LOG_MANAGER,'SCOPE')
        plot(t,z);   
    end;    
end

% 3rd harmonics wave
if strcmp(genactor,'confitest1')
    t=[0:0.05:4*pi];
    z=-1/9*sin(3*t);
end;
%%

% plot a wave
if strcmp(genactor,'confitest0')
    t=[0:0.05:4*pi];
    z=sin(t);
    plot(t,z);
end;

%% ================================================================
%% LOG MANAGER
%% ================================================================
    if strcmp(LOG_MANAGER,'SCOPE')
        plot(t,z);   
    end;    
    if strcmp(LOG_MANAGER,'FFTER')
        zs=fft(z);
        zr=real(zs);zi=imag(zs);
        zf= log(sqrt(zr.*zr + zi.*zi));
        tt=1:100;
        plot(tt,zf(tt));
    end;
    if strcmp(LOG_MANAGER,'PHASE')
        zs=fft(z);
        zr=real(zs);zi=imag(zs);
        zp= atan(zi./zr);
        tt=1:100;
        plot(tt,zp(tt));
    end;

%% ================================================================
%% Interface
%% ================================================================
gene=z; %this is the name which should be used by caller 
    