function waitAllDone(timeout)

%function waitAllDone(timeout)
% This function blocks (via polling/spinlock) until the flags/spinlocks in
% ALL_DONE are true (timeout is in seconds)

global ALL_DONE;

resolution = 0.1;
time = 0;
while time < timeout
    if ALL_DONE
        return;
    end
    pause(resolution);
    time = time + resolution;
end
if ALL_DONE
    return; %last chance!
end
error('waitAllDone:Timeout', 'Command timed out.');

end