function stimSet_021(exptInfo,preExptData)

% Repeat courtship song and pulse song through middle speaker

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
voltage = [0.04,0.08,0.16];
numberOfStimuli = 2*length(voltage);
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 6
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
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = voltage(1);
    case 2
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = voltage(2);
    case 3
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = voltage(3);
    case 4
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = voltage(1);
    case 5
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = voltage(2);
    case 6
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = voltage(3);
end
end




