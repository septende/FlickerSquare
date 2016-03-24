function [ timeUse,keyUse ] = FlickerDisplay( window,resolusion, Hz, displaytime, screenNumber )
Screen('Flip',window);
RefreshRate=Screen('GetFlipInterval',window);
TotalFrames=round(displaytime/RefreshRate); % total frames within total display time
FramesPerStimuli=round(1/Hz/RefreshRate); % total frames per stimulus flicker cycle
FrameCounter=0;
Screen('FillRect',window,[255 255 255],resolusion);
StartTime=Screen('Flip',window);
[screenXpixels, screenYpixels] = Screen('WindowSize',screenNumber);
while 1
    if FrameCounter==TotalFrames % the end of display
        timeUse=displaytime;
        break;
    end
    if ~mod(FrameCounter,FramesPerStimuli) % at the end of a full flicker cycle
        linecolor=[0 0 0];
    else
        linecolor=[255 255 255];
    end
   % Screen('DrawLines', window, [100 200 200 200 200 100 100 100;...
   %                             100 100 100 200 200 200 200 100], 2, linecolor);
     Screen('DrawLines', window, [screenXpixels/2-100 screenXpixels/2+100 screenXpixels/2+100 screenXpixels/2+100 screenXpixels/2+100 screenXpixels/2-100 screenXpixels/2-100 screenXpixels/2-100;...
                                  screenYpixels/2-100 screenYpixels/2-100 screenYpixels/2-100 screenYpixels/2+100 screenYpixels/2+100 screenYpixels/2+100 screenYpixels/2+100 screenYpixels/2-100], 2.5, linecolor);
    Screen('Flip',window);
    FrameCounter=FrameCounter+1;
    [~,EndTime,keyCode,~]=KbCheck;
    if (max(keyCode)==1)
        timeUse=EndTime-StartTime;
        keyUse=keyCode;
        break
    else
        keyUse=0;
    end
end
 end
