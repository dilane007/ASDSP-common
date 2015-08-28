% FREQZ - returns and plots the frequency response of a digital filter
%
% USAGE
%
% [h,w] = freqz(N,D,n) returns the n-point frequency response vector, h, and the
%         corresponding angular frequency vector, w, for the digital filter with 
%         numerator and denominator polynomial coefficients stored in N and D, 
%         respectively.
%
% [h,w] = freqz(N,D,n,'whole') returns the frequency response at n sample points 
%         around the entire unit circle.
% 
% [h,f] = freqz(N,D,n,fs) returns the frequency response vector, h, and the 
%         corresponding physical frequency vector, f, for the digital filter 
%         with numerator and denominator polynomial coefficients stored in N and 
%         D, respectively, given the sampling frequency, fs.
%
% [h,f] = freqz(N,D,n,'whole',fs) returns the frequency at n points ranging 
%         between 0 and fs.
%
%     h = freqz(N,D,w) returns the frequency response vector, h, at the 
%         normalized frequencies supplied in w.
%
%     h = freqz(N,D,f,fs) returns the frequency response vector, h, at the 
%         physical frequencies supplied in f.
%
% Licensed under the GPL
% Copyright (C) 2014 Jonathan Weaver <jonw0224@aim.com>

function [TF,w] = freqz(N,D,n,whole,fs)

% Version 1.0 - 5/6/2014
    
% This file is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

    % Default setup
    retf = 0
    wtop = pi;
    
    % Parse how freqz is being called, setup accordingly
    if nargin == 4
        if ischar(whole)
            if strcmp(whole,'whole')
                % freqz(N,D,n,'whole')
                wtop = 2*pi;
            end
        else
            % freqz(N,D,f,fs) or freqz(N,D,n,fs)
            retf = 1;
            fs = whole;
        end
    end
    if nargin == 5
        % freqz(N,D,n,'whole',fs)
        wtop = 2*pi;
        retf = 1;
    end
    if length(n) > 1
        % freqz(N,D,w) or freqz(N,D,f,fs)
        if retf
            w = 2*pi*n./fs;
        else
            w = n;
        end
    else
        % freqz(N,D,n)
        w = linspace(0,wtop,n);
    end
    
    % Define the unit circle path for frequency evaluation
    ejw = exp(-j.*w);    
    
    % Ensure the demoninator and numerator vectors are the same length
    if length(N) < length(D)
        N = [zeros(1,length(D)-length(N)) N];
    end
    if length(N) > length(D)
        D = [zeros(1,length(N)-length(D)) D];
    end
    a = size(D);

    % Calculate the frequency response of the filter (evaluate around the unit circle)
    if(a(1) == 1)
        Wv = zeros(a(2),length(ejw));
        for i = 0:(a(2)-1)
            Wv(a(2)-i,:) = ejw.^(i-1);
        end
        TF = (N*Wv)./(D*Wv);
    else
        error('N and D should be column vectors');
    end
    % Plot frequency if necessary
    if retf
        w = w*fs/2;
    end
    % Plot Magnitude
    subplot(2,1,1);
    plot(w/pi, 20*log10(abs(TF)));
    xlim([w(1)/pi w(length(w))/pi]);
    title('Magnitude', 'fontsize', 14);
    ylabel('Magnitude (dB)');
    a = gca
    set(a, 'xminorgrid','on');
    grid on;

    % Plot Phase
    subplot(2,1,2);
    plot(w/pi, 180/pi*angle(TF));
    xlim([w(1)/pi w(length(w))/pi]);
    title('Phase', 'fontsize', 14);
    ylabel('Phase (Degrees)');
    a = gca
    set(a, 'xminorgrid','on');
    grid on;
    
    % Label frequency correctly
    if retf
        xlabel('Frequency (Hz)');
    else
        xlabel('Normalized Frequency (x pi rad/sample)');
    end

    % Ensure we return frequency when asked
    if retf
        w = w./pi;
    end
end