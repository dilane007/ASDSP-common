% [zo ze]=SPLITOE(x,len)
%Note: index starts at odd; odd even odd even ...
function [zo ze]=splitoe(x,len)
    zo= x(1:2:len);
    ze= x(2:2:len);
    end