function ballStimSet_010(exptInfo)

% Plays range of stimuli from only the right speaker and records particle velocity microphone
% measurement

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 8;
trialMeta.totalStimNum = numberOfStimuli;
trialsPerBlock = numberOfStimuli;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
rep = 0;
while rep < 400
    trialMeta.pauseDur = rand(1,1);
    pause on 
    pause(trialMeta.pauseDur);
    trialMeta.stimNum = stimRan(count);
    [stim,LEDtrig] = pickStimulus(trialMeta.stimNum);
    stim.speaker = 1; 
    trialMeta.outputCh = switchSpeakerBall(stim.speaker);
    acquireBallTrialWithLed(stim,LEDtrig,exptInfo,trialMeta);
    if count == trialsPerBlock
        count = 1;
        stimRan = speakerNonRan(randperm(trialsPerBlock));
        rep = rep + 1; 
    else
        count = count+1;
    end
end

    function [stim,LEDtrig] = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PulseSong;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 4;
                stim.endPadDur = 6;
                LEDtrig = noStimulus;
                LEDtrig.waveDur = stim.totalDur;
            case 2
                stim = SineWave; 
                stim.carrierFreqHz = 100;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 4;
                stim.endPadDur = 6;
                LEDtrig = noStimulus;
                LEDtrig.waveDur = stim.totalDur;
            case 3
                stim = AmTone;
                stim.carrierFreqHz = 300;
                stim.modFreqHz = 16;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 4;
                stim.endPadDur = 6;
                LEDtrig = noStimulus;
                LEDtrig.waveDur = stim.totalDur;
            case 4
                stim = PulseSong;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 4;
                stim.endPadDur = 6;
                LEDtrig = WindStimulus; 
                LEDtrig.windDur = stim.totalDur - 6;
                LEDtrig.startPadDur = 1;
                LEDtrig.endPadDur = 5;
            case 5
                stim = SineWave;
                stim.carrierFreqHz = 100;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 4;
                stim.endPadDur = 6;
                LEDtrig = WindStimulus; 
                LEDtrig.windDur = stim.totalDur - 6;
                LEDtrig.startPadDur = 1;
                LEDtrig.endPadDur = 5;
            case 6
                stim = AmTone;
                stim.carrierFreqHz = 300;
                stim.modFreqHz = 16;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 4;
                stim.endPadDur = 6;
                LEDtrig = WindStimulus; 
                LEDtrig.windDur = stim.totalDur - 6;
                LEDtrig.startPadDur = 1;
                LEDtrig.endPadDur = 5;
            case 7
                stim = noStimulus; 
                stim.waveDur = 15; 
                LEDtrig = WindStimulus; 
                LEDtrig.windDur = stim.totalDur - 6;
                LEDtrig.startPadDur = 1;
                LEDtrig.endPadDur = 5;
            case 8
                stim = noStimulus; 
                stim.waveDur = 11; 
                LEDtrig = WindStimulus; 
                LEDtrig.windDur = stim.totalDur - 6;
                LEDtrig.startPadDur = 1;
                LEDtrig.endPadDur = 5;
        end
    end

end
