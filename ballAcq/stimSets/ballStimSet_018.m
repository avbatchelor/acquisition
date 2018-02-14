function ballStimSet_018(exptInfo)

% Sine waves of different frequencies with 300Hz pip stimulus for
% reference, 2 speakers

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
rng('shuffle');
numberOfStimuli = 21;
trialsPerBlock = 2*numberOfStimuli;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

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
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 100;
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 2
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 140;
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 3
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 225;
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 4
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 300;
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 5
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 800;
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 6
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 100;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 7
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 140;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 8
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 225;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 9
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 300;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 10
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 800;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 3;
                stim.speakerChannel = 2;
                stim.speakerAngle = 45;
            case 11
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 100;
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 12
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 140;
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 13
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 225;
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 14
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 300;
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 15
                stim = SineWave;
                % Stimulus parameters
                stim.carrierFreqHz = 800;
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 16
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 100;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 17
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 140;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 18
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 225;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 19
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 300;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 20
                stim = PipStimulus;
                % Stimulus parameters
                stim.carrierFreqHz = 800;
                stim.envelope = 'cosine';
                % Direction
                stim.speaker = 6;
                stim.speakerChannel = 3;
                stim.speakerAngle = 315;
            case 21
                stim = noStimulus;
                stim.startPadDur = 2;
                stim.endPadDur = 2.3216;
        end
    end

end
