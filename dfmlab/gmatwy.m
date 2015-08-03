function z = gmatwy(siz,rgain,igain)
% DESCRIPTION z= gmatwy(size,rgain,igain)  
%  Complex Weighted Identity matrix
z = (rgain + igain*i)*eye(siz);

