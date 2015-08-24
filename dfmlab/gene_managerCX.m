%=======================================================
%dfmlab\gene_managerCX.m
% A genrator of complex sequences
function gene= gene_managerCX(genactor,genemess)
global verbo
global OFP

%% ================================================================
%% input arguments
%% ================================================================
if (nargin <2 ) genemess.nx=2559; end;
if (nargin <1 ) genactor='basic'; end;
    
if exist('verbo.gene') && verbo.gene >=1 , fprintf(OFP,'[GENE cplx]=%s\n',genactor);end;

%% ================================================================
%% IMPLEMENTATION
%% ================================================================
    Fs = 1000;   
    t = 0:1/Fs:.3;
    rand('state',0);
    npoints=genemess.nx;
    switch(genactor)
        case{'basic'}
            gene.ch1 = cos(2*pi*t*200)+ i*sin(2*pi*t*200);  
            [gene.ch2, gene.ch3] = SeqSinCosSq(32000);
            gene.ch4 = SeqUp(0.12345,0.0001,0.98765);
        case{'chall8'}
            gA = seqCplx(1,npoints)';
            gB = seqCplx(0.8,npoints)';
            gC = seqCplx(0.6,npoints)';
            gD = seqCplx(0.4,npoints)';
            gE = seqCplx(0.2,npoints)';
            gF = seqCplx(0.01,npoints)';
            gG = seqCplx(-0.2,npoints)';
            gH = seqCplx(-0.4,npoints)';
            gene.chA =[gA gB gC gD gE gF gG gH];
        otherwise
            error('missing genactor');
    end;
end    
 

function [g] = seqCplx(gain,npoints)
%  step=(2*pi)/256251 x 8 channels; big!! 
 step=(2*pi)/npoints;% 2600 x 8 channels
 t = -pi:step:pi;
 g= gain* exp(2*t*sqrt(-1));
end
