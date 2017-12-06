function ballStimSet_019(exptInfo)

% Produces the default pip train while switching between two speakers with
% calibrated command voltage

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
rng('shuffle');
numberOfStimuli = 16;
trialsPerBlock = 2*numberOfStimuli;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));
% stimRan = repmat([1,2,3,4],[1,10]);

count = 1;
stop = 0;
while stop == 0
    trialMeta.stimNum = stimRan(count);
    stim = pickStimulus(trialMeta.stimNum);
    trialMeta.totalStimNum = numberOfStimuli;
    trialMeta.outputCh = stim.speakerChannel;
    disp(['Output Channel = ',num2str(trialMeta.outputCh)])
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
                stim.carrierFreqHz = 100;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 2
                stim = PipStimulus;
                stim.carrierFreqHz = 140;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 3
                stim = PipStimulus;
                stim.carrierFreqHz = 200;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 4
                stim = PipStimulus;
                stim.carrierFreqHz = 225;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 5 
                stim = PipStimulus;
                stim.carrierFreqHz = 300;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 6
                stim = PipStimulus;
                stim.carrierFreqHz = 500;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 7 
                stim = PipStimulus;
                stim.carrierFreqHz = 800;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 8 
                stim = SineWave;
                stim.carrierFreqHz = 225;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 9
                stim = PipStimulus;
                stim.carrierFreqHz = 100;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 10 
                stim = PipStimulus;
                stim.carrierFreqHz = 140;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 11 
                stim = PipStimulus;
                stim.carrierFreqHz = 200;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 12
                stim = PipStimulus;
                stim.carrierFreqHz = 225;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 13
                stim = PipStimulus;
                stim.carrierFreqHz = 300;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 14
                stim = PipStimulus;
                stim.carrierFreqHz = 500;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 15
                stim = PipStimulus;
                stim.carrierFreqHz = 800;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;  
            case 16
                stim = SineWave;
                stim.carrierFreqHz = 225;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 17 
                stim = noStimulus;
                stim.startPadDur = 2.5; 
                stim.endPadDur = 2.5;
        end
    end

end
