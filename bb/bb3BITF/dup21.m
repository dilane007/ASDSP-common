% z=DUP21(x,yvec)
% returns z, a duplicated version of x;
% TYPE: unc
% SHAPE: x scalar, z= vector of same size as y= 1D,2D
% RANGE: as type
function z=dup21(xscalar,yvec)
    z= zeros(size(yvec)) + xscalar ;
end