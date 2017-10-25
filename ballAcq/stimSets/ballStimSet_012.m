function ballStimSet_012(exptInfo)

% Plays range of stimuli and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 6;
trialMeta.totalStimNum = numberOfStimuli;
trialsPerBlock = numberOfStimuli;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
rep = 0;
while rep < 11
    trialMeta.pauseDur = rand(1,1);
    pause on 
    pause(trialMeta.pauseDur);
    trialMeta.stimNum = stimRan(count);
    pickStimNum = round(trialMeta.stimNum/2);
    stim = pickStimulus(pickStimNum);
    trialMeta.outputCh = switchSpeakerBall(stim.speaker);
    acquireBallTrialWithPV(stim,exptInfo,trialMeta);
    if count == trialsPerBlock
        count = 1;
        stimRan = speakerNonRan(randperm(trialsPerBlock));
        rep = rep + 1; 
    else
        count = count+1;
    end
end

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 3;     % Left speaker   
                stim.maxVoltage = 1.5;
            case 2
                stim = PipStimulus;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 3;     % Left speaker   
                stim.maxVoltage = 0.8*1.5;
            case 3
                stim = PipStimulus;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 3;     % Left speaker   
                stim.maxVoltage = 0.4*1.5;
            case 4
                stim = PipStimulus;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 3;     % Left speaker   
                stim.maxVoltage = 0.2*1.5;
            case 5
                stim = PipStimulus;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 3;     % Left speaker   
                stim.maxVoltage = 0.1*1.5;
            case 6
                stim = PipStimulus;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 3;     % Left speaker   
                stim.maxVoltage = 0.05*1.5;
        end
    end

end
