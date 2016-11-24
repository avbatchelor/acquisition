function stimSet_023(exptInfo,preExptData)

% Play AM at 250Hz carrier through middle speaker

%% Speaker or piezo 
exptInfo.stimType = s;

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 5;
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
    case num2cell(1:5)
        stimNumStart = 1;
        modInd = stimNum-stimNumStart+1;
        modRange = 2.^(0:4);
        stim = AmTone;
        stim.carrierFreqHz = 250;
        stim.modFreqHz = modRange(modInd);
        stim.maxVoltage = 0.08;
end
end




