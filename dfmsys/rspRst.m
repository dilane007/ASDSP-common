 function [event] = rspRst( addr, msgId, result )
% function [event] = rspRst
%
%   Check received message to determine whether to generate a completion event.
%
%   event:  0:  none
%           1:  ACK complete
%           2:  RSP complete
%

    global ackActive;
    global rspActive;
    global ackCount;
    global rspCount;
    global rspResult;
    global count;
    global rspcount;
    
    event = 0; % none
    count=0;
    rspcount=0;
    check4ACKcomplete(addr,msgId);    
    check4RSPcomplete(addr,msgId,result);
end
    
     
    
    function check4ACKcomplete(addr,msgId)    
    if  ackActive(addr+1, msgId) ~= 0      %cannot find this stuff
        ackActive(addr+1, msgId)  = 0;
        ackCount = ackCount - 1;
        if (0 >= ackCount)
            event = -2; % ACK complete
        end
    end
    end


    function check4RSPcomplete(addr,msgId,result)
    if  rspActive(addr+1, msgId) > 0
        if (2 < nargin) && (0 == rspResult) && (0 ~= result)
            rspResult = result;
        end
        rspActive(addr+1, msgId) = rspActive(addr+1, msgId) - 1;
        rspCount = rspCount - 1;
        if (0 >= rspCount)
            event = -3; % RSP complete
        end
    end
end

