function out=addr2seg(addrMtrNum)
%
% function addr2seg(addrMtrNum)
%
% This function takes an n x 2 matrix of [SCUaddress SCUMotorNumber; ...], where the
% axis format is 0 = x+, 1 = x-, 2 = y+, 3 = y-, and returns
% [segment axis; ...];
% If argument is n x 1, only the SCUaddress is converted to segment.
% There is no axis information in this case.
%-----------------------------------------------------------------------
% DFM issues
% a) SEG2ADDR_TABLE is empty
%-----------------------------------------------------------------------
global SEG2ADDR_TABLE;

disp('addr2seg');
nrow=size(addrMtrNum,1)
%addrMtrNum(1,1)=8;
ncln=size(addrMtrNum,2)
if (ncln == 2)
    out=zeros(nrow,2)
    for i=1:nrow,
        row = find(SEG2ADDR_TABLE(:,1) == addrMtrNum(i,1))
        out(i,:)= [row-1 find(SEG2ADDR_TABLE(row,2:5) == addrMtrNum(i,2))-1]
    end
else
    out=zeros(nrow,1)
    for i=1:nrow,
        row = find(SEG2ADDR_TABLE(:,1) == addrMtrNum(i,1))
        out(i)= row-1
    end
end
