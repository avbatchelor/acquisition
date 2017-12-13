function ballStimSet_014(exptInfo)

% Plays range of stimuli and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 49;
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
    trialMeta.outputCh = stim.speakerChannel;
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
            case num2cell(1:7)
                midVoltage = .5; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 100;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(8:14)
                midVoltage = .3; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 7;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 140;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(15:21)
                midVoltage = .3; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 14;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 200;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(22:28)
                midVoltage = .3; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 21;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 225;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(29:35)
                midVoltage = .3; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 28;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 300;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(36:42)
                midVoltage = .3; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 35;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 500;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(43:49)
                midVoltage = .3; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 42;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 800;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
        end
    end

end
