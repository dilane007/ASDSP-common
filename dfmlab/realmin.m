%[DFM] z= strncmpi(s1, s2, n)
% shape, type, range checking: none
% value checking: identical to matlab
%% usage: strncmpi (s1, s2, n)
%%
%% Compare the first n characters of two strings, ignoring case, 
%% returning 1 if they are the same, and 0 otherwise.
%%
%% Note: For compatibility with Matlab, Octave's strncmpi function
%% returns 1 if the strings are equal, and 0 otherwise.  This is
%% just the opposite of the corresponding C library function.
function status = strncmpi(s1, s2, n)
  if (nargin != 3)
    disp('strncmpi (s, t, n)');return;
  end

  status = 0;		% Assume strings are different
  if (isstr (s1) && isstr(s2))
    status = strncmp(upper(s1),upper(s2),n);
  end
end

