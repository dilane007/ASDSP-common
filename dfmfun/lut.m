function out=lut(a,b)

out=log(1+exp(-abs(a+b)))-log(1+exp(-abs(a-b)));
