function ballStimSet_017(exptInfo)

% Cardinal directions with 225 Hz pip stimulus

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
rng('shuffle');
numberOfStimuli = 4;
trialsPerBlock = 5*numberOfStimuli;
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
                stim.carrierFreqHz = 225;
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 0;
            case 2
                stim = PipStimulus;
                stim.carrierFreqHz = 225;
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 3
                stim = PipStimulus;
                stim.carrierFreqHz = 225;
                stim.speaker = 3;       
                stim.speakerChannel = 2;
                stim.speakerAngle = 90;
            case 4
                stim = PipStimulus;
                stim.carrierFreqHz = 225;
                stim.speaker = 6;       
                stim.speakerChannel = 3;
                stim.speakerAngle = 180;
        end
    end

end
