function stimSet_018(exptInfo,preExptData)

% Single step with 5 second duration to switch olfactometer on and off,
% with camera

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 1;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 100
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
        stim = WindStimulus;
end
end
