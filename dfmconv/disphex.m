function z = disphex(x)
%older version was in common; kept in any case
   x=double(x);
   idx= (x<0);
   x(idx)=l2ul(x(idx)); 
   z = uint32(x);
end

%older function found in common
% function z = disphex(x)
%       z = l2ul(int32(x));
% end