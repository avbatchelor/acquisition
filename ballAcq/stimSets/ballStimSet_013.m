function ballStimSet_013(exptInfo)

% Plays range of stimuli and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 7;
trialMeta.totalStimNum = numberOfStimuli;
trialsPerBlock = numberOfStimuli;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
rep = 1;
while rep < 11
    trialMeta.pauseDur = rand(1,1);
    pause on
    pause(trialMeta.pauseDur);
    trialMeta.stimNum = stimRan(count);
    pickStimNum = round(trialMeta.stimNum);
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
                stim = SineWave;
                stim.carrierFreqHz = 100;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.maxVoltage = 0.9732;
            case 2
                stim = SineWave;
                stim.carrierFreqHz = 140;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.maxVoltage = 0.72674;
            case 3
                stim = SineWave;
                stim.carrierFreqHz = 200;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.maxVoltage = 0.6284;
            case 4
                stim = SineWave;
                stim.carrierFreqHz = 225;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.maxVoltage = 0.6732;
            case 5
                stim = SineWave;
                stim.carrierFreqHz = 300;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.maxVoltage = 0.6386;
            case 6
                stim = SineWave;
                stim.carrierFreqHz = 500;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.maxVoltage = 0.6017;
            case 7
                stim = SineWave;
                stim.carrierFreqHz = 800;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.maxVoltage = 0.4519;
        end
    end

end
