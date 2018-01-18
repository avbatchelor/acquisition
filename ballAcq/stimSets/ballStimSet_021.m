function ballStimSet_021(exptInfo)

% 225Hz pip stimuli with different AM envelopes, 2 speakers at 45 and 315

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
rng('shuffle');
numberOfStimuli = 4;
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
                % Stimulus parameters
                stim.carrierFreqHz = 225;
                stim.envelope = 'cos-theta';
                % Direction 
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 2
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 225;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 1;
                stim.speakerChannel = 1;
                stim.speakerAngle = 315;
            case 3
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 225;
                stim.envelope = 'cos-theta';
                % Direction
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
            case 4
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 225;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 2;
                stim.speakerChannel = 0;
                stim.speakerAngle = 45;
        end
    end

end
