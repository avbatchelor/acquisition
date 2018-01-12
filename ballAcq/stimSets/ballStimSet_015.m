function ballStimSet_014(exptInfo)

% Plays range of stimuli and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 28;
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
    stim.speaker = 1;     % Left speaker
    stim.speakerChannel = 1;
    stim.startPadDur = 1;
    stim.endPadDur = 1;
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
                midVoltage = 1.75; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 100;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(8:14)
                midVoltage = 1.7; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 7;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 140;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(15:21)
                midVoltage = 1.0; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 14;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 500;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(22:28)
                midVoltage = 0.9; 
                increment = 0.05;                 
                voltageRange = [midVoltage-increment*3:increment:midVoltage,midVoltage+increment:increment:midVoltage+increment*3];
                seriesNum = stimNum - 21;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 800;
                stim.maxVoltage = voltageRange(seriesNum);
        end
    end

end
