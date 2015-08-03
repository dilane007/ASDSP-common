function tmrStop()
    global FsmTimer;
    global FsmTimerCur;
    
    stop(FsmTimer(FsmTimerCur+1));
end
