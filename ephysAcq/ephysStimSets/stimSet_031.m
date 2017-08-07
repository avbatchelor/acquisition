function stimSet_031(exptInfo,preExptData)

% Play a range of pure tones with different volumes through middle speaker

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Hard coded parameters
% voltage = [0.16,0.32,0.64];
% carrierRange = 50:50:450;
% voltage = [0.32];
% carrierRange = 50:25:300;
numberOfStimuli = 1;


%% Set up and acquire with the stimulus set
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
        stim = noStimulus;
        stim.waveDur = 10; 
end
end




