function ballStimSet_013(exptInfo)

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
            case 1
                stim = SineWave;
                stim.carrierFreqHz = 100;
                stim.startPadDur = 1;
                stim.endPadDur = 1;
                stim.speaker = 3;     % Left speaker
                stim.speakerChannel = 1;
%             case 2
%                 stim = SineWaveVolSet;
%                 stim.carrierFreqHz = 140;
%                 stim.startPadDur = 1;
%                 stim.endPadDur = 1;
%                 stim.speaker = 5;     % Left speaker
%                 stim.speakerChannel = 3;
%                 stim.maxVoltage = 0.5971;
%             case 3
%                 stim = SineWaveVolSet;
%                 stim.carrierFreqHz = 200;
%                 stim.startPadDur = 1;
%                 stim.endPadDur = 1;
%                 stim.speaker = 5;     % Left speaker
%                 stim.speakerChannel = 3;
%                 stim.maxVoltage = 0.5557;
%             case 4
%                 stim = SineWaveVolSet;
%                 stim.carrierFreqHz = 225;
%                 stim.startPadDur = 1;
%                 stim.endPadDur = 1;
%                 stim.speaker = 5;     % Left speaker
%                 stim.speakerChannel = 3;
%                 stim.maxVoltage = 0.5954;
%             case 5
%                 stim = SineWaveVolSet;
%                 stim.carrierFreqHz = 300;
%                 stim.startPadDur = 1;
%                 stim.endPadDur = 1;
%                 stim.speaker = 5;     % Left speaker
%                 stim.speakerChannel = 3;
%                 stim.maxVoltage = 0.5647;
%             case 6
%                 stim = SineWaveVolSet;
%                 stim.carrierFreqHz = 500;
%                 stim.startPadDur = 1;
%                 stim.endPadDur = 1;
%                 stim.speaker = 5;     % Left speaker
%                 stim.speakerChannel = 3;
%                 stim.maxVoltage = 0.5321;
%             case 7
%                 stim = SineWaveVolSet;
%                 stim.carrierFreqHz = 800;
%                 stim.startPadDur = 1;
%                 stim.endPadDur = 1;
%                 stim.speaker = 5;     % Left speaker
%                 stim.speakerChannel = 3; 
%                 stim.maxVoltage = 0.3714;
        end
    end

end
