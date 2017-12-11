function ballStimSet_014(exptInfo)

% Plays range of stimuli and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 36;
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
            case num2cell(1:6)
                voltageRange = 1.35:0.05:1.6;
                seriesNum = stimNum;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 100;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(7:12)
                voltageRange = 1.05:0.05:1.3;
                seriesNum = stimNum - 6;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 140;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(13:18)
                voltageRange = 0.90:0.05:1.15;
                seriesNum = stimNum - 12;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 200;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(19:24)
                voltageRange = 0.45:0.05:0.7;
                seriesNum = stimNum - 18;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 300;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(25:30)
                voltageRange = 0.90:0.05:1.15;
                seriesNum = stimNum - 24;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 500;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
            case num2cell(31:36)
                voltageRange = 0.5:0.05:.75;
                seriesNum = stimNum - 30;
                stim = SineWaveVolSet;
                stim.carrierFreqHz = 800;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 6;     % Left speaker
                stim.speakerChannel = 3;
                stim.maxVoltage = voltageRange(seriesNum);
%             case num2cell(37:42)
%                 voltageRange = 0.45:0.025:.575;
%                 seriesNum = stimNum - 36;
%                 stim = SineWaveVolSet;
%                 stim.carrierFreqHz = 800;
%                 stim.startPadDur = 1;
%                 stim.endPadDur = 1;
%                 stim.speaker = 6;     % Left speaker
%                 stim.speakerChannel = 3;
%                 stim.maxVoltage = voltageRange(seriesNum);
        end
    end

end
