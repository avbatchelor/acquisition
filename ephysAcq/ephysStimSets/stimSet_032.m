function stimSet_032(exptInfo,preExptData)

% Chirps with three different volumes 

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Run current injection trial 
currentInjectionTrial(exptInfo,preExptData)

%% Set up and acquire with the stimulus set
numberOfStimuli = 6;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 3
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    acquireTrialWithCamera('none',stim,exptInfo,preExptData,trialMeta);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
        repeat = repeat + 1;
    else
        count = count+1;
    end
end

%% Run current injection trial 
currentInjectionTrial(exptInfo,preExptData)

end

function stim = pickStimulus(stimNum)
switch stimNum
    case 1
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage =0.64;
        stim.endPadDur = 10;
    case 2
        stim = Chirp;
        stim.startFrequency  = 1500;
        stim.endFrequency    = 90;
        stim.maxVoltage =0.64;
        stim.endPadDur = 10;
    case 3
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage =0.16;
        stim.endPadDur = 10;
    case 4
        stim = Chirp;
        stim.startFrequency  = 1500;
        stim.endFrequency    = 90;
        stim.maxVoltage =0.16;
        stim.endPadDur = 10;
    case 5
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage =0.04;
        stim.endPadDur = 10;
    case 6
        stim = Chirp;
        stim.startFrequency  = 1500;
        stim.endFrequency    = 90;
        stim.maxVoltage =0.04;
        stim.endPadDur = 10;
end
end




