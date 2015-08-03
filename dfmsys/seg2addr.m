function out=seg2addr(segNumAxis)
%
% function seg2addr(segNumAxis)
%
% This function takes an n x 2 matrix of [segmentNumber axis; ...], where the
% axis format is 0 = x+, 1 = x-, 2 = y+, 3 = y-, and returns
% [SCUaddress SCUMotorNumber; ...];
%
% If argument is n x 1, only the segment address is converted.  There is no
% axis information in this case.
global SEG2ADDR_TABLE;

n=size(segNumAxis,1);
if size(segNumAxis,2) == 2
    out=zeros(n,2);
    for i=1:n,
        row = segNumAxis(i,1)+1;
        out(i,:)=[SEG2ADDR_TABLE(row,1) SEG2ADDR_TABLE(row,segNumAxis(i,2)+2)];
    end
else
    out=SEG2ADDR_TABLE(segNumAxis+1,1);
end


