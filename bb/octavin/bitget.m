% ## Copyright (C) 2004, 2005, 2006, 2007, 2009 David Bateman
% ##
% ## -*- texinfo -*-
% ## @deftypefn {Function File} {@var{X} =} bitget (@var{a},@var{n})
% ## Return the status of bit(s) @var{n} of unsigned integers in @var{a}
% ## the lowest significant bit is @var{n} = 1.
% ##
% ## @example
% ## @group
% ## bitget (100, 8:-1:1)
% ## @result{} 0  1  1  0  0  1  0  0 
% ## @end group
% ## @end example
% ## @seealso{bitand, bitor, bitxor, bitset, bitcmp, bitshift, bitmax}
% ## @end deftypefn
% 
% ## Liberally based of the version by Kai Habel from octave-forge

function z = bitget (A, n)
% 
%    if (nargin != 2)
%      print_usage ();
%    end

  if (isa (A, 'double'))
      bitmax=power(2,53)-1;%[freem] 
      Amax = log2(bitmax) + 1;
      cf = @double;
  else
    if (isa (A, 'uint8'))
      Amax = 8;
      cf = @uint8
    elseif (isa (A, 'uint16'))
      Amax = 16;
      cf = @uint16;
    elseif (isa (A, 'uint32'))
      Amax = 32;
      cf = @uint32;
    elseif (isa (A, 'uint64'))
      Amax = 64;
      cf = @uint64;
    elseif (isa (A, 'int8'))
      Amax = 8;
      cf = @int8;
    elseif (isa (A, 'int16'))
      Amax = 16;
      cf = @int16;
    elseif (isa (A, 'int32'))
      Amax = 32;
      cf = @int32;
    elseif (isa (A, 'int64'))
      Amax = 64;
      cf = @int64;
    else
      error ('invalid class %s', class (A));
    end
  end

  m = double (n(:));
  if (any (m < 1) || any (m > Amax))
    error ('n must be in the range [1,%d]', Amax);
  end

  x=A
  ashift= n - 1
%   ashift= uint8 (n) - uint8 (1)
  v = bitshift(cf(1), ashift)
  y = bitand(x, uint16(v)) 
  z= (y ~= cf(0))
%   X = bitand (A, bitshift (cf(1), uint8 (n) - uint8 (1))) ~= cf(0)
end