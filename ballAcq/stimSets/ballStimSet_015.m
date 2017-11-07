function ballStimSet_015(exptInfo)

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
            case num2cell(1:6)
                voltageRange = 0.625:0.025:0.75;
                seriesNum = stimNum - 0;
                stim = SineWave;
                stim.carrierFreqHz = 225;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.maxVoltage = voltageRange(seriesNum);
%             case num2cell(7:12)
%                 voltageRange = 0.65:0.025:.775;
%                 seriesNum = stimNum - 6;
%                 stim = SineWave;
%                 stim.carrierFreqHz = 140;
%                 stim.startPadDur = 1;
%                 stim.endPadDur = 1;
%                 stim.speaker = 3;     % Left speaker
%                 stim.maxVoltage = voltageRange(seriesNum);
        end
    end

end
