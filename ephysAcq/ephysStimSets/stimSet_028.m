function stimSet_028(exptInfo,preExptData)

% Depolarising current injections 

%% Speaker or piezo 
exptInfo.stimType = 'n';

%% Archive this code
archiveExpCode(exptInfo)

%% Load settings
ephysSettings;
sampRate = settings.sampRate.out;

%% Set up and acquire with the stimulus set
numberOfStimuli = 2;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    [stim,currentCommand] = pickStimulus(trialMeta.stimNum,sampRate);
    switchSpeaker(stim.speaker);
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta,currentCommand);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
        repeat = repeat + 1;
    else
        count = count+1;
    end
end

end

function [stim,currentCommand] = pickStimulus(stimNum,sampRate)
switch stimNum
    case 1 % +ve current injection without a stimulus
        stim = noStimulus;
        stim.waveDur = 14;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (5)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 8*(0.0394/4);
    case 2 % without a stimulus with larger +ve current injection
        stim = noStimulus;
        stim.waveDur = 14;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (5)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 4*(0.0394/4);
end
end




