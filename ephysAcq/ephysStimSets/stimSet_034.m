function stimSet_034(exptInfo,preExptData)

% Play a range of stimuli refined for vPN1 neurons (pips, chirps, courtship/pulse song, pure tones and AM tones) through middle speaker

%% Speaker or piezo
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Run current injection trial
currentInjectionTrial(exptInfo,preExptData)

%% Set up and acquire with the stimulus set
numberOfStimuli = 1;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 3
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    acquireTrial('none',stim,exptInfo,preExptData,trialMeta);
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
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 0.32;
        stim.numPips = 50;
        stim.carrierFreqHz = 150;
    case 2
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 0.16;
        stim.numPips = 50;
        stim.carrierFreqHz = 150;
    case 3
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 0.08;
        stim.numPips = 50;
        stim.carrierFreqHz = 150;
    case 4
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 0.04;
        stim.numPips = 50;
        stim.carrierFreqHz = 150;
end
end




