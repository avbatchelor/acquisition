function ballStimSet_017(exptInfo)

% Produces the default pip train while switching between two speakers with
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
                stim = SineWave;
                stim.carrierFreqHz = 100;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
                stim.speaker = 1;     
                stim.maxVoltage = 0.93413;
                stim.speakerAngle = 0; 
            case 2
                stim = SineWave;
                stim.carrierFreqHz = 100;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
                stim.speaker = 2;      
                stim.maxVoltage = 0.8338;
                stim.speakerAngle = 90;
            case 3
                stim = SineWave;
                stim.carrierFreqHz = 100;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
                stim.speaker = 3;       % Right speaker
                stim.maxVoltage = 0.92103;
                stim.speakerAngle = 180;
            case 4
                stim = SineWave;
                stim.carrierFreqHz = 100;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
                stim.speaker = 4;       % Right speaker
                stim.maxVoltage = 0.9732;
                stim.speakerAngle = 270;
        end
    end

end
