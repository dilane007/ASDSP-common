%usage: strncmp (s1, s2, n)
%Compare the first n characters of two strings, returning 1 if
%they are the same, and 0 otherwise.
%Note: For compatibility with Matlab, Octave's strncmp function
%returns 1 if the strings are equal, and 0 otherwise.  This is
%just the opposite of the corresponding C library function.
function status = strncmp(s1, s2, n)
  status = 0;		%Assume strings are different
  if (isstr (s1) && isstr(s2))
    c1 = columns (s1);
    c2 = columns (s2);
    if (n < 1)		%Comparing less than 1 character of the string
      status = 0;	%will always say they are not equal (for Matlab compatibility
    elseif ((n <= c1) && (n <= c2))
        status = strcmp(s1(:,1:n),s2(:,1:n));
    else 
       status = 0;
    end;
  end;

end

