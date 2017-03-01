function stimSet_029(exptInfo,preExptData)

% Single step with 5 second duration to switch olfactometer on and off,
% with camera

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 2;
stimRan = randperm(numberOfStimuli);

count = 1;
stimCount = 1; 
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    trialMeta.stimNum = stimCount;
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    if count == 1
        fprintf(['\nMake sure vial contains ',stim.odor])
        pause
    end
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == 3
        count = 1;
        stimCount = stimCount + 1; 
    else
        count = count+1;
    end
    if stimCount == 3
        stimCount = 1; 
    end
end

end

function stim = pickStimulus(stimNum)
switch stimNum
    case 1
        stim = WindStimulus;
        stim.odor = 'no odor';
    case 2 
        stim = WindStimulus; 
        stim.odor = 'CVA';
end
end
