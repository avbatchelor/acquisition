function stimSet_016(exptInfo,preExptData)

% Square wave with 1Hz and 0.05Hz freq, maxVoltage is 1 through piezo

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 2;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 10
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
        stim = SquareWave;
        stim.maxVoltage = 4; 
    case 2
        stim = SquareWave;
        stim.maxVoltage = 4; 
        stim.freq = 0.05;
        stim.waveDur = 60;
end
end
