function stimSet_024(exptInfo,preExptData)

% Play a range of pure tones through middle speaker to test tuning through
% speaker

%% Speaker or piezo 
exptInfo.stimType = s;

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 9;
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
    case num2cell(1:9)
        stimNumStart = 1;
        carrierInd = stimNum-stimNumStart+1;
        stim = SineWave;
        carrierRange = 100+(0:8).*15;
        stim.carrierFreqHz = carrierRange(carrierInd);
        stim.maxVoltage = 0.08;
end
end




