function [asin,acos] = SeqSinCosSq(gain)

t = -pi:0.01:pi;
asin= gain.*(sin(t).^2);
acos= gain.*(cos(t).^2);



                                                                                                      




