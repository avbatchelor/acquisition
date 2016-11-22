function stimSet_026(exptInfo,preExptData)

% Play a range of stimuli (pips, chirps, courtship/pulse song, clicks, pure tones and AM tones) through 15um piezo (max voltage is 4)

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 27;
voltage = 1;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 3
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum,voltage);
    switchSpeaker(stim.speaker);
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
        repeat = repeat + 1;
    else
        count = count+1;
    end
end

end

function stim = pickStimulus(stimNum,voltage)
switch stimNum
    case 1
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = voltage; 
        stim.carrierFreqHz = 150; 
    case 2
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage = voltage; 
        stim.startFrequency  = 400;
        stim.endFrequency    = 17;
        stim.mode = 'piezo';
    case 3
        stim = Chirp;
        stim.startFrequency  = 17;
        stim.endFrequency    = 400;
        stim.maxVoltage = voltage;
        stim.mode = 'piezo';
    case 4
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = voltage; 
    case 5
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = voltage; 
    case 6
        stim = SquareWave;
        stim.speaker = 2;
        stim.maxVoltage = voltage; 
    case num2cell(7:16)
        freqRange = (1:8).*50;
        stimNumStart = 7-1;
        freqNum = stimNum - stimNumStart;
        stim = SineWave;
        stim.carrierFreqHz = freqRange(freqNum);
        stim.maxVoltage = voltage; 
    case num2cell(17:21)
        modFreqRange = 2.^(0:4);
        stimNumStart = 17-1;
        modFreqNum = stimNum - stimNumStart;
        stim = AmTone;
        stim.carrierFreqHz = 300;
        stim.modFreqHz = modFreqRange(modFreqNum);
        stim.maxVoltage = voltage;
    case 22
        stim = StepPlusSine; 
        stim.stepDirection = 'forward';
        stim.carrierFreqHz = 150;
    case 23 
        stim = StepPlusSine; 
        stim.stepDirection = 'backward';
        stim.carrierFreqHz = 150;
    case 24 
        stim = StepPlusSine; 
        stim.stepDirection = 'forward';
        stim.carrierFreqHz = 300;
    case 25
        stim = StepPlusSine; 
        stim.stepDirection = 'backward';
        stim.carrierFreqHz = 300;
    case 26
        stim = StepPlusSine; 
        stim.stepDirection = 'forward';
        stim.carrierFreqHz = 100;
    case 27
        stim = StepPlusSine; 
        stim.stepDirection = 'backward';
        stim.carrierFreqHz = 100;
end
end
