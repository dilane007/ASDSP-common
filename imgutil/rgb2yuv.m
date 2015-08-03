function Y=rgb2yuv(X,type)
%
% Y=rgb2yuv(X,type)
%    Convert RGB to YUV format
%
%    X=image 3D matrix (3 components)
%    type = YUV type
%           'ccir8'     = CCIR601 (default)
%           'hivis8'    = HiVision
%           'smpte8'    = SMPTE 274M
%           'ccir10'     = CCIR601 (default)
%           'hivis10'    = HiVision
%           'smpte10'    = SMPTE 274M
%   

% Copyright Genesis Microchip Inc.
% Daniel Stan/Gheorghe Berbecel [May 00]

% Checking the number of arguments
if nargin==1,
  type='ccir8';
elseif nargin==2,
else
  error('Wrong number of arguments');
end;

[vsize,hsize,frames]=size(X);
%if frames~=3,
%   error('Not a 3 component image.');
%end

if isa(X,'uint8')
    use8bit=true;
elseif isa(X,'uint16')
    use8bit=false;
else
    error('Image must be uint8 or uint16 format.');
end

% Change to double precision
X=double(X);
% Initialize the output matrix
Y=zeros(size(X));


% Sort the image type
switch type
   case 'ccir8',
      % Y component
      Y_N=[0.299 0.587 0.114];
      RGB2YUV_g=[219;224;224]/255;
      RGB2YUV_c=[16;128;128];
   case 'ccir10',
      % Y component
      Y_N=[0.299 0.587 0.114];
      RGB2YUV_g=4*[219;224;224]/1023;
      RGB2YUV_c=4*[16;128;128];
   case 'hivis8',
      % Y component
      Y_N=[0.2125 0.7154 0.9279];
      RGB2YUV_g=[219;224;224]/255;
      RGB2YUV_c=[16;128;128];
   case 'hivis10',
      % Y component
      Y_N=[0.2125 0.7154 0.9279];
      RGB2YUV_g=4*[219;224;224]/1023;
      RGB2YUV_c=4*[16;128;128];
   case 'smpte8',
      % Y component
      Y_N=[0.2126 0.7152 0.0722];
      RGB2YUV_g=[219;224;224]/255;
      RGB2YUV_c=[16;128;128];
   case 'smpte10',
      % Y component
      Y_N=[0.2126 0.7152 0.0722];
      RGB2YUV_g=4*[219;224;224]/1023;
      RGB2YUV_c=4*[16;128;128];
end

% B-Y component
B_Y=[0  0 1]-Y_N;
% R-Y component
R_Y=[1 0 0 ]-Y_N;

% The color diff will be normalized to vary between -0.5 and +0.5
% B-Y normalized
B_Y_N=0.5*B_Y/max(abs(B_Y));
% R-Y normalized
R_Y_N=0.5*R_Y/max(abs(R_Y));   

% The matrix of transformation is calculated
% Y=219*Y_N +16
% U=224*B_Y_N+128
% V=224*R_Y_N+128   
% The /255 is done because R G B are normalized to 1
RGB2YUV_m=[RGB2YUV_g(1)*Y_N; RGB2YUV_g(2)*B_Y_N; RGB2YUV_g(3)*R_Y_N];

% The equation becomes YUV=RGB2YUV_m*[R G B]'+RGB2YUV_c;
% and this is the floating point equation which will be inversed to 
% produce the YUV to RGB conversion
for i=1:3,
   % For every color plane take a line of the converison matrix
   % and multiply it with the intial image color matrix and add a constant
   for j=1:3,
      Y(:,:,i)=Y(:,:,i)+RGB2YUV_m(i,j)*X(:,:,j);
   end
   Y(:,:,i)=Y(:,:,i)+RGB2YUV_c(i);
end

if use8bit
    % Quantize to 8 bits
    Y=uint8(Y);
else
    % Quantize to 16 bits
    Y=uint16(Y);
end
