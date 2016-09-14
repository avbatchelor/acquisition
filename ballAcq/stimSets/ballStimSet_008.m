function ballStimSet_008(exptInfo)

% Plays range of stimuli and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 1;
trialMeta.totalStimNum = numberOfStimuli;
trialsPerBlock = numberOfStimuli;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
while count < 7
    trialMeta.pauseDur = rand(1,1);
    pause on 
    pause(trialMeta.pauseDur);
    if any([1,2,5,6] == count)
        stim = pickStimulus(1);
        trialMeta.stimNum = 2;
        pause;
    else
        pause;
        stim = pickStimulus(2);
        trialMeta.stimNum = 2;
    end
    stim.speaker = 3; 
    trialMeta.outputCh = switchSpeakerBall(stim.speaker);
    acquireBallTrialWithPV(stim,exptInfo,trialMeta);
    count = count+1;
end

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 2
                stim = noStimulus;
                stim.startPadDur = 4.5;
                stim.endPadDur = 0;
        end
    end
end
