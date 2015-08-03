function tmrStart( delay, varargin )
    global FsmTimer;
    global FsmTimerCur;
    
    if 0 < size(varargin,2)
        event = varargin{1};
    else
        event = 0;
    end
    FsmTimerCur = 1 - FsmTimerCur;
    stop(FsmTimer(FsmTimerCur+1));
    FsmTimer(FsmTimerCur+1).TimerFcn   = {@notesEventHandler, {event}};
    FsmTimer(FsmTimerCur+1).StartDelay = delay;
    start(FsmTimer(FsmTimerCur+1));
end
