function waitAck(timeout)

%function waitAck(timeout)
% This function blocks (via polling/spinlock) until an ack is received

global ACKED;

resolution = 0.1;
time = 0;
while time < timeout
    if ACKED
        return;
    end
    pause(resolution);
    time = time + resolution;
end
if ACKED
    return; %last chance!
end
error('waitAck:Timeout', 'Command timed out.');

end