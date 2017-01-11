function stimSet_020(exptInfo,preExptData)

% Play a range of stimuli refined for vPN1 neurons (pips, chirps, courtship/pulse song, pure tones and AM tones) through middle speaker

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 18;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 3
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum);
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

function stim = pickStimulus(stimNum)
switch stimNum
    case 1
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 0.08;
        stim.carrierFreqHz = 150; 
    case 2
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage = 0.08;
    case 3
        stim = Chirp;
        stim.startFrequency  = 1500;
        stim.endFrequency    = 90;
        stim.maxVoltage = 0.08;
    case 4
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = 0.08;
    case 5
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = 0.08;
    case num2cell(6:13)
        stimNumStart = 6;
        carrierInd = stimNum-stimNumStart+1;
        stim = SineWave;
        carrierRange = (1:8).*50;
        stim.carrierFreqHz = carrierRange(carrierInd);
        stim.maxVoltage = 0.08;
    case num2cell(14:18)
        stimNumStart = 14;
        modInd = stimNum-stimNumStart+1;
        modRange = 2.^(0:4);
        stim = AmTone;
        stim.carrierFreqHz = 150;
        stim.modFreqHz = modRange(modInd);
        stim.maxVoltage = 0.08;
end
end




