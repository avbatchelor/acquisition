function stimSet_036(exptInfo,preExptData)

% Sine wave with and without CVA 

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Run current injection trial
currentInjectionTrial(exptInfo,preExptData)

%% Specify stimulus 
stim = OptoStimulus;
stim.optoDur = 1; 

%% Specify states 
state{1} = 'Manual shutter open'; 
state{2} = 'Manual shutter closed';

%% Set up and acquire with the stimulus set
count = 1;
stimCount = 1;
stim.state = state{1};
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimCount;
    switchSpeaker(stim.speaker);
    if count == 1
        fprintf(['\nMake sure state is ',stim.state])
        pause
    end
    acquireTrialWithOdor('none',stim,exptInfo,preExptData,trialMeta);
    if count == 3
        count = 1;
        stimCount = stimCount+1;
        stim.state = state{2};
    else
        count = count+1;
    end
    if stimCount == 3
        stimCount = 1;
        repeat = repeat + 1;
        stim.state = state{1};
    end
end

%% Run current injection trial
currentInjectionTrial(exptInfo,preExptData)


end




