function stimSet_042(exptInfo,preExptData)

% Sine wave with and without CVA 

%% Hard-coded params 
injectionDur = 1.25;

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Run current injection trial
currentInjectionTrial(exptInfo,preExptData)

%% Load settings
ephysSettings;
sampRate = settings.sampRate.out;

%% Specify stimulus 


%% Specify states 
state{1} = 'Manual shutter open'; 
state{2} = 'Manual shutter closed';

%% Set up and acquire with the stimulus set
numberOfStimuli = 5;
stimRan = randperm(numberOfStimuli);

count = 1;
stim.state = state{1};
repeat = 1;

while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    [stim,currentCommand] = pickStimulus(trialMeta.stimNum,state);
%     fprintf(['\nMake sure state is ',stim.state])
%     pause
    acquireTrialWithOdor('none',stim,exptInfo,preExptData,trialMeta,currentCommand);
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


function [stim,currentCommand] = pickStimulus(stimNum,state)
switch stimNum
    case 1 % current injection during stimulus
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 0.25;
        stim.state = state{1};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
    case 2 % current injection during stimulus
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 0.5;
        stim.state = state{1};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
    case 3 % current injection during stimulus
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 1;
        stim.state = state{1};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
    case 4 % current injection during stimulus
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 2;
        stim.state = state{1};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
    case 5 % current injection during stimulus
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 4;
        stim.state = state{1};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
end
end
