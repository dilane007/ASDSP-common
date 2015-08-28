% FIR1 - window based finite impulse response filter design
%
% USAGE
%
% b = fir1(n,Wn) returns row vector b containing the n+1 coefficients of an 
%     order n lowpass FIR filter. This is a Hamming-window based, linear-phase 
%     filter with normalized cutoff frequency Wn. The output filter coefficients,
%     b, are ordered in descending powers of z.
%
%     Wn is a number between 0 and 1, where 1 corresponds to the Nyquist 
%     frequency.
%
%     If Wn is a two-element vector, Wn = [w1 w2], fir1 returns a bandpass 
%     filter with passband w1 < w < w2.
%
% b = fir1(n,Wn,'ftype') specifies a filter type, where 'ftype' is:
%
%     'high' for a highpass filter with cutoff frequency Wn.
%
%     'stop' for a bandstop filter, if Wn = [w1 w2]. The stopband frequency 
%     range is specified by this interval. 
%
%     fir1 always uses an even filter order for the highpass and bandstop 
%     configurations. This is because for odd orders, the frequency response 
%     at the Nyquist frequency is 0, which is inappropriate for highpass and 
%     bandstop filters. If you specify an odd-valued n, fir1 increments it by 1.
%
% b = fir1(n,Wn,window) uses the window specified in column vector window for 
%     the design. The vector window must be n+1 elements long. If no window is 
%     specified, fir1 uses a Hamming window of length n+1
%
% b = fir1(n,Wn,'ftype',window) accepts both the 'ftype' and window parameters

% Licensed under the GPL
% Copyright (C) 2014 Jonathan Weaver <jonw0224@aim.com>

function c = fir1(N,wn,ftype,window)

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
    
    % Parse how the function is called
    if nargin == 3
        if ~ischar(ftype)
            % fir(N,wn,window)
            window = ftype;
            ftype=='low';
        end
    end
    if nargin == 2
        ftype = 'low';
    end
    if length(wn) == 1
        if strcmp(ftype,'high')
            % High Pass
            filterType = 2;
        else
            % Low Pass
            filterType = 0;
        end
    else
        if strcmp(ftype,'stop')
            % Band Stop
            filterType = 3;
        else
            %Band Pass
            filterType = 1;
        end
    end

    % If high pass or band stop, make sure filter order is even
    if filterType == 2 || filterType == 3
        if mod(N,2) == 1
            N = N+1;
        end
    end

    % Declare coefficient index
    n = 0:N;

    % Use the window provided or use the default Hamming Window
    try
        if length(window) > N+1
            window = window(1:N+1);
        elseif length(window) < N+1
            window = [window zeros(1,N+1-length(window))];
        end
    catch
        % Hamming Window
        window = 0.54-0.46.*cos(2.*pi.*(n)./(N));
    end
        
    % Calculate the filter coefficients
    if filterType == 0
        % Low Pass Filter
        filt = sin(wn*pi*(n-N/2))./pi./(n-N/2);
        filt(find(isnan(filt))) = wn;
    elseif filterType == 2
        % High Pass Filter
        filt = -sin(wn*pi*(n-N/2))./pi./(n-N/2);
        filt(find(isnan(filt))) = 1-wn;
    elseif filterType == 3    
        % Band Stop Filter
        filt = sin(wn(1)*pi*(n-N/2))./pi./(n-N/2) - sin(wn(2)*pi*(n-N/2))./pi./(n-N/2);
        filt(find(isnan(filt))) = 1-(wn(2)-wn(1));
    elseif filterType == 1    
        % Band Pass Filter
        filt = sin(wn(2)*pi*(n-N/2))./pi./(n-N/2) - sin(wn(1)*pi*(n-N/2))./pi./(n-N/2);
        filt(find(isnan(filt))) = (wn(2)-wn(1));
    end
    
    % Apply window to filter
    c = filt.*window;
    
end