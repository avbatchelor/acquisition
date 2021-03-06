function ballStimSet_001(exptInfo)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
rng('shuffle');
numberOfStimuli = 2;
trialsPerBlock = 20;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
stop = 0;
while stop == 0 
    trialMeta.stimNum = stimRan(count);
    stim = pickStimulus(trialMeta.stimNum);
    trialMeta.outputCh = switchSpeakerBall(stim.speaker);
    acquireBallTrial(stim,exptInfo,trialMeta);
    if count == trialsPerBlock
        count = 1;
        stimRan = speakerNonRan(randperm(trialsPerBlock));
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
                stim.speaker = 1;     % Left speaker   
                stim.maxVoltage = 1.5;
            case 2
                stim = PipStimulus;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 3;       % Right speaker 
                stim.maxVoltage = 1.5;
        end
    end

end
