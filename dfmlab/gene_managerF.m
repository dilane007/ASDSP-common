%% dfmlab\gene_managerF.m
function gene=gene_managerF(genactor,genemess,loadcoefs);
global verbo
global OFP

if exist('verbo.gene') && verbo.gene >= 1,    fprintf(OFP,'[GENE F]actor=%s\n',genactor); end;

    
%default%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 nx=0;
 b =    [-0.004465461051254
            -0.004324228005260
            +0.012676739550326
            +0.074351188907780
            +0.172173206073645
            +0.249588554524763
            +0.249588554524763
            +0.172173206073645    
            +0.074351188907780    
            +0.012676739550326    
            -0.004324228005260  
            -0.004465461051254]';
 
 seq1L64= [-0.586023264 0.193218928 -0.820398955 -0.219300454 ...
          -0.715453062 -0.102597429 -0.175933032 0.04778151  ...
          -0.54787350 0.03014896 0.201154538 -0.796503411 ...
          -0.277834039 -0.570692582 0.45912504 0.325311236 ...
          -0.042284223 -0.411029482 -0.728748752 -0.561478317 ...
           0.038548177 0.244473206 0.698429675 -0.668141386 ...
          -0.366522195 0.711346874 -0.982613044 0.081459292 ...
          -0.333837576 -0.033997697 -0.374161836 0.437987832 ...
          -0.33495535 -0.274693075  -0.94505359 -0.794906946 ...
          -0.893210942 -0.219637033 -0.972976104 -0.656742008 ...
          -0.637477001 -0.099049658 -0.381758657 -0.040335933  ...
          -0.328020433 -0.650475309 -0.111936047 -0.391055514 ...
          -0.926192171 0.214614882  -0.14692413 0.608855652 ...
           0.314719117 -0.722863135  -0.704018935 -0.373693935 ...
          -0.554228387  0.448682927 0.539279987   0.638294107 ...
          -0.807209556 -0.587321158 0.647415697   0.573367088];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if nargin >=3, b=loadcoefs;    end;
        if nargin >=2, nx=genemess.nx;    end;
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    switch(genactor)
        case{'basic'}
            gene.seq1 = [0.42 0.12 -0.12 -0.33 -0.15 0.22 0.55 0.11 -0.29 -0.44 -0.30 0.24 0.5 0.21 -0.3 -0.45 -0.2 0.1 ]; 
            gene.coef1= 0.3:0.13:0.7;%len=4
            gene.coef2= 0.3:0.05:0.9;
        case{'magene4ch'}
            % timebase 
            t = linspace(0,10*pi,nx)';
            % impulse
            impulse = zeros(nx,1); 
            impulse(1) = 1;
            % sines
            f0=0.1; 
            f1=2;
            sine2 = sin(2*pi*t*f0) + 0.1*sin(2*pi*t*f1); 
            % maximer     
            maxim = sign(fliplr(b))';
            maximo = repmat(maxim,ceil(nx/length(b)),1);%back to column;
            maximer = maximo(1:nx);
            % chirp
            f_chirp=1/16; % Target frequency
            chirp=  sin(pi*f_chirp*t.^2);  % Linear chirp

        case {'chA' 'rand-L64#1'}
            gene.chA=seq1L64;
        case {'step' 'step-L80#1'}
            gene.chB=0.8*ones(1,80);
            gene.chB(1)=0;
        case {'sine'}
            for tt=1:2000, seqSin =0.8*sin(2*pi*tt/100);end;
            gene.chC=seqSin;
            
        case {'confitest'}
          t=[0:0.05:4*pi];
          z=sin(t);
          plot(t,z);
          gene.ch1=z;
           
        otherwise
            disp('missing genactor');
    end;
         
    % assign channels
    switch(genactor)
        case{'magene4ch'}
            gene.ch1=impulse;
            gene.ch2=maximer;
            gene.ch3=sine2;
            gene.ch4=chirp;
            gene.coef1=b;
    end;

end