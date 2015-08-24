%=======================================================
%dfmlab\gene_manager10.m
% A 10 channels gene; each channel has a q format range
%(1) byte
%(2) u byte
%(3) short
%(4) u short
%(5) long
%(6) u long
%(7) unc (float)
%(8) unc (float)
%(9) unused
%(10) unused

%=======================================================
function gene= gene_manager10(genactor)
global verbo
global OFP

if exist('verbo.gene') && verbo.gene >= 1,    fprintf(OFP,'[GENE10]actor=%s\n',genactor); end;
%== CREATE SEQUENCES
lSeqA = SeqUp(0.1,0.2,0.7)*power(2,31);
sSeqA = SeqUp(0.1,0.2,0.7)*power(2,15);
bSeqA = SeqUp(0.1,0.2,0.7)*power(2,7);
ubSeqA = SeqUp(-0.1,0.2,0.7)*power(2,8);
usSeqA = SeqUp(-0.1,0.2,0.7)*power(2,16);
ulSeqA = SeqUp(-0.1,0.2,0.7)*power(2,32);
lSeqB = SeqDn(0,0.1,-0.7)*power(2,31);
sSeqB = SeqDn(0,0.1,-0.7)*power(2,15);
bSeqB = SeqDn(0,0.1,-0.7)*power(2,7);
ulSeqB = SeqDn(0,0.1,-0.7)*power(2,32);
usSeqB = SeqDn(0,0.1,-0.7)*power(2,16);
ubSeqB = SeqDn(0,0.1,-0.7)*power(2,8);
lSeqC = SeqDn(-1.0,0.1,-1.5)*power(2,31);
e=exp(1);

%== ASSIGN SEQUENCES TO CHANNELS
    
switch(genactor)
    case{'sequp'},  
        gene.ch1 = bSeqA;
        gene.ch2 = ubSeqA;
        gene.ch3 = sSeqA;
        gene.ch4 = usSeqA;
        gene.ch5 = lSeqA;
        gene.ch6 = ulSeqA;
    case{'seqdn'},  
        gene.ch1 = bSeqB;
        gene.ch2 = ubSeqB;
        gene.ch3 = sSeqB;
        gene.ch4 = usSeqA;
        gene.ch5 = lSeqB;
        gene.ch6 = ulSeqB;
        
    case{'sequp#1'},     gene.ch7 = SeqUp(0.0001,0.234,100);
    case{'sequp#2'},     gene.ch7 = SeqUp(-123.45,0.98,32.1);
    case{'seqDD-L8#1'},  gene.ch7= [1,sqrt(2),e,pi,2,4,8,16];
    case{'seqNEGPOS-L8#1'}, gene.ch7= [1,-1,sqrt(2),-sqrt(2),e,-e,pi,-pi];
    case{'seqEXP2-L8#1'},  gene.ch7= [2,4,8,16,32,128,1024,65536];
    case{'seqFRAC-L8#1'},  gene.ch7= [0.999,0.5*sqrt(2),0.6,0.5,0.4,0.3,0.2,0.1];
    case{'seqK-L5#1'},     gene.ch7 = [1,sqrt(2),e,pi,4];       gene.ch8 = [5,5,5,5,5];
    case{'seqK-L4#1'},     gene.ch7 = [1,2,2,2];         gene.ch8 = [1,2,4,6];
    case{'seqK-L4#2'},    gene.ch7 = [2.2,2.2,2.2,2.2];   gene.ch8 = [5.1,5.2,5.3,5.4];
    otherwise,  error('Gene actor unknown')
end 

end
 