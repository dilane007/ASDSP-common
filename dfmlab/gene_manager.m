%== common\gene_manager
%1.3 <06feb2007> massive infusion of real gene 
%1.5 <04Mar2007> addition seqfunpi (row then cln)
%1.6 <27Jul2015> changed geneactor to genactor
                 added verbo.gene  
%=====================================
global Fs time T L Nsamp 

if verbo.gene==1, fprintf(OFP,'[GENE] genactor= %s \n',genactor);end;

sequp= -11:10;
seqdwn=10:-1:-10;
seqtri=[sequp seqdwn];
seq44= [1 2 3 4; 4 5 6 7; -1 -2 -3 0; -5 -4 -2 1];
seq5= [1 2 3 4 5];

geneA= 1:10;
geneB= 1:10;
geneC= 1:10;
geneD= 1:10;
geneE= 1:10;
geneF= 1:10;
geneG= 1:10;
switch(genactor)
  case('geneA'),    geneA= 5:2:24;
  case('geneB'),    geneB= -0.987:0.123:0.987;
  case('geneC'),    geneC= repmat(seqtri,1,2000);
  case('geneD'),    geneD= [1:10000; 4:10003 ; 7:10006; 10:10009];
  case('geneE'),    geneE= linspace(-0.987,0.123,1024);
  case('geneF'),    geneF= repmat(seq44,32); %128x128
  case('geneG'),    geneG= repmat(seq5,1,10);
  case('geneH'),    geneH= 1:1000;

  case('seqran1')
    geneA = randint(1,100,16);
  case('seqran2')
    geneA = randint(1000,1,64); 
  case('seqfunpi')
    geneA = linspace(-pi,pi,10240)';
  case('seqcplx')
    Fs = 80000;   time = (0:1/Fs:0.01)';
    geneA = sin(2*pi*300*time)+ i*sin(2*pi*600*time); 
  case('seqcplx2')
    geneA = 4*(rand(1000,1)-1/2)+j*4*(rand(1000,1)-1/2);
    M=4;    
  case('matseq1')
    Fs = 1000;    T = 1/Fs;  % Sample time
    L = 1000;                     % Length of signal
    time = (0:L-1)*T;                % Time vector
    amp1  = 0.7;  f1=50;
    amp2  = 1.0;  f2=120;
    gsig   = amp1*sin(2*pi*f1*time) + amp2*sin(2*pi*f2*time); 
    gnoise = 2*randn(size(time));
    geneA  = gsig+gnoise;    
  case {'matseq2'}
        Fs = 100;     time = (0:2*Fs+1)'/Fs;
        geneA = sin(2*pi*time); % Sinusoidal signal
  case('matseq3')
        Fs = 80000;   time = (0:1/Fs:0.01)';
        geneA = sin(2*pi*300*time)+2*sin(2*pi*600*time); % Original signal
  case('matseq2ch')
        Fs = 8000;   time = (0:Fs)'/Fs;  
        s1 = sin(2*pi*300*time)+2*sin(2*pi*600*time); % Channel 1
        s2 = sin(2*pi*150*time)+2*sin(2*pi*900*time); % Channel 2
        geneA = [s1,s2]; % Two-channel signal
  case('matseq4')
        Fs = 100;  time = (0:2*Fs+1)'/Fs;
        geneA = sin(2*pi*time) + sin(4*pi*time);
  case('matseq5')
        Fs = 270000;     time = (0:1/Fs:0.01)';
        geneA = sin(2*pi*300*time)+2*sin(2*pi*600*time);
  case('seq1008')
    Fs = 10000;    T = 1/Fs; 
    L  = 10000;     time = (0:L-1)*T;        
    geneA  = sin(2*pi*1008*time); 
  case('seqm1008')
    Fs = 10000;    T = 1/Fs; 
    L  = 10000;    time = (0:L-1)*T;        
    geneA = sin(2*pi*1008*time); 
    geneM(1,:) = geneA; 
     for i =2:5
        geneM(i,:) = 0; end; 
  case('seqdtmf')
    Fs = 10000;    T = 1/Fs;  % Sample time
    L  = 1000;                     % Length of signal
    time = (0:L-1)*T;                % Time vector
    amp1  = 0.7;  f1=870;
    amp2  = 0.5;  f2=1200;
    gsig   = amp1*sin(2*pi*f1*time) + amp2*sin(2*pi*f2*time); 
    gnoise = 0;
    geneA  = gsig+gnoise;    
  case('seq3ton')
    Fs = 10000;    T = 1/Fs;  % Sample time
    L  = 1000;                     % Length of signal
    time = (0:L-1)*T;                % Time vector
    gsig1 =  1.0*sin(2*pi*3000*time); 
    gsig2 =  0.3*sin(2*pi*1000*time); 
    gsig3 =  0.1*sin(2*pi*300*time); 
    gnoise = 0;
    geneA  = gsig1+gsig2+gsig3+gnoise;    
  case('amdemod')
        Fs = 80000;   time = (0:1/Fs:0.01)';
        Fc = 10000; 
        [num,den] = butter(10,Fc*2/Fs); % Lowpass filter
        gsig = sin(2*pi*300*time)+2*sin(2*pi*600*time); % 
        geneA = ammod(gsig,Fc,Fs); % generator is a AM modulated 
  case('pam')
        M = 8; 
        n = 10000; % Number of symbols to process
        x = randint(n,1,M); % Create message signal.
        geneA = pammod(x,M); % Modulate.
  case('matseqran1')
        M = 2; 
        geneA   = randint(5000,1,M); 
        Fs = 16;   Nsamp = 17;  
  case('matseqran2')
        M = 16; % Alphabet size
        geneA = randint(5000,1,M); % Message signal
        Nsamp = 4; % Oversampling rate
  case('matseqran3')
        M = 4; 
        geneA = randint(1000,1,4); 
        Fs = 32;   Nsamp = 8; 
  case('matseqran4')
        geneA = randint(99,1);
        Nsamp = 8; 
  case('seqran0123')
        M = 4; 
        g = randint(1000,1,M); 
        geneA = mod(g,3); 
  otherwise
    disp('geneactor is missing');
end;

