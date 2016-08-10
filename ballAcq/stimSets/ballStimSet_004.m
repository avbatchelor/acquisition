function ballStimSet_004(exptInfo)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 6;
trialMeta.totalStimNum = numberOfStimuli;
trialsPerBlock = numberOfStimuli;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
stop = 0;
while stop == 0
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
                stim = CourtshipSong;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 2
                stim = PulseSong;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 3
                stim = SineWave;
                stim.carrierFreqHz = 100;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
        end
    end

end
