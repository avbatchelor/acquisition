function ballStimSet_006(exptInfo)

% Plays range of stimuli and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 42;
trialMeta.totalStimNum = numberOfStimuli;
trialsPerBlock = numberOfStimuli;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
rep = 0;
while rep < 4
    rep = rep + 1; 
    trialMeta.pauseDur = rand(1,1);
    pause on 
    pause(trialMeta.pauseDur);
    trialMeta.stimNum = stimRan(count);
    pickStimNum = round(trialMeta.stimNum/2);
    stim = pickStimulus(pickStimNum);
    if mod(trialMeta.stimNum,2) == 1
        stim.speaker = 1; 
    else 
        stim.speaker = 3; 
    end
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
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 2
                stim = Chirp;
                stim.maxVoltage = 1.5;
                stim.startFrequency  = 400;
                stim.endFrequency    = 17;
                stim.mode = 'speaker';
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 3
                stim = Chirp;
                stim.startFrequency  = 17;
                stim.endFrequency    = 400;
                stim.maxVoltage = 1.5;
                stim.mode = 'speaker';
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 4
                stim = CourtshipSong;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 5
                stim = PulseSong;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 6
                stim = SquareWave;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case num2cell(7:16)
                freqRange = 25.*sqrt(2).^((-1:8));
                stimNumStart = 7-1;
                freqNum = stimNum - stimNumStart;
                stim = SineWave;
                stim.carrierFreqHz = freqRange(freqNum);
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case num2cell(17:21)
                modFreqRange = 2.^(0:4);
                stimNumStart = 17-1;
                modFreqNum = stimNum - stimNumStart;
                stim = AmTone;
                stim.carrierFreqHz = 300;
                stim.modFreqHz = modFreqRange(modFreqNum);
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
        end
    end

end
