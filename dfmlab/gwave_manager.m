% ariti\max168\gene_manager.m

% wave= sum of out of phase harmonics; outter wave = hat shape (genactor= 'hat1')
% outshaped wave = harmonics not in phase  (genactor= 'outshaped')
% triangular wave  (genactor='triwave')
% 3rd harmonics wave(genactor= 'confitest1')
% plot a wave (genactor= 'confitest0')
%-----------------------------------------------------------------
function gene= gene_manager(genactor,genemess)
global verbose
global OFP
global NULL  
   
%% ================================================================
%% input arguments
%% ================================================================
if (nargin <2 ) genemess=0;end; 
if (nargin <1 ) genactor='confitest0';end;
    
fprintf(OFP,'[GENE] entering gene=%s ---------------------\n',genactor);

%% ================================================================
%% IMPLEMENTATION
%% ================================================================


%% ================================================================
%% GENE 8
%% ================================================================
if (strcmp (genactor,'gene8'))
    rowlen=length([0:0.05:10*pi]);
    gene=zeros(rowlen,8);
    t=[0:0.05:10*pi];
%1 inner wave= sum of out of phase harmonics; outter wave = hat shape 
    sign=1;
    z=0;
    for ii=3:2:15
    %tests
        x=ii;
        A= sign /(x*x);
        t = t+ (ii-1)*0.1;%%added phase for each frequency
        gen= A*sin(x*t);
        sign=-sign;
        z = z+gen;
    end;
    z = 8/(pi*pi)*z;% dont forget normalising constant
    z= z .* sin(0.1*t);
    gene(:,1)=z;
    gene(:,8)=z*10;

%2 outshaped wave = harmonics not in phase
    sign=1;
    z=0;
    for ii=3:2:23
        x=ii;
        A= sign /(x*x);
        t = t+ (ii-1)*0.1;%%added phase for each frequency
        gen= A*sin(x*t);
        sign=-sign;
        z = z+gen;
    end;
    z = 8/(pi*pi)*z;% dont forget normalising constant
    gene(:,2)=z;

%3,4 triwave
    BEG=1;
    LAST=23;% %must be odd harmonics
    sign=1;
    z=0;
    for ii=BEG:2:LAST
        x=ii;
        A= sign /(x*x);
        gen= A*sin(x.*t);
        sign=-sign;
        z = z+gen;
    end;
    z = 1/(pi*pi)*z;% dont forget normalising constant
    gene(:,3)=z;
    gene(:,4)=8*z;

%6,7  2xrandom
    z = rand(rowlen,rowlen);
    gene(:,6)=z(1,:)';
    gene(:,7)=z(2,:)';
%
end;


%% ================================================================
%% GENE SINGLE
%% ================================================================
if strcmp(genactor,'random')
    row= genemess.para1;
    cln= genemess.para2;
    gain= genemess.para3;
    z = rand(row,cln).*gain;
    gene=z;
end;

% plot a wave
if strcmp(genactor,'confitest0')
    t=[0:0.05:4*pi];
    z=sin(t);
    plot(t,z);
    gene=z;
end;
fprintf(OFP,'[GENE] leaving gene=%s ---------------------------\n',genactor);

%% ================================================================
%% Output Interface
%% ================================================================
%% ================================================================
end    