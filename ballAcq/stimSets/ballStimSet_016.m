function ballStimSet_016(exptInfo)

% Produces the default pip train while switching between two speakers at 45 and 315 with
% calibrated command voltage 

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
                stim.carrierFreqHz = 225;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 1;     % Left speaker   
                stim.speakerAngle = 315;
            case 2
                stim = PipStimulus;
                stim.carrierFreqHz = 225;
                stim.startPadDur = 2; 
                stim.endPadDur = 2; 
                stim.speaker = 3;       % Right speaker 
                stim.speakerAngle = 45; 
        end
    end

end
