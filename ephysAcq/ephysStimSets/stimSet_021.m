function stimSet_021(exptInfo,preExptData)

% Repeat courtship song and pulse song through middle speaker

%% Speaker or piezo 
exptInfo.stimType = s;

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 2;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 11
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
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = 0.08;
    case 2
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = 0.08;
end
end




