function ballStimSet_011(exptInfo)

% Plays range of stimuli and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)


%% Set up and acquire with the stimulus set
count = 1;
stimCount = 1;
repeat = 1;
while repeat < 3
    trialMeta.stimNum = stimCount;
    stim = pickStimulus(trialMeta.stimNum);
    if count == 1
        fprintf(['Make sure stim is ',stim.description,'\n'])
        pause
    end
    stim.speaker = 3;
    trialMeta.outputCh = switchSpeakerBall(stim.speaker);
    acquireBallTrialWithPV(stim,exptInfo,trialMeta);
    if count == 3
        count = 1;
        stimCount = stimCount + 1;
    else
        count = count+1;
    end
    if stimCount == 3
        stimCount = 1;
        repeat = repeat + 1;
    end
end

end

function stim = pickStimulus(stimNum)
switch stimNum
    case 1
        stim = SineWave;
        stim.carrierFreqHz = 200;
        stim.maxVoltage = 1.5;
        stim.endPadDur = 3; 
%         stim.description = 'no air flow';
    case 2
        stim = SineWave;
        stim.carrierFreqHz = 200; 
        stim.maxVoltage = 1.5;
%         stim.description = 'air flow';
        
end
end


