function stimSet_038(exptInfo,preExptData)

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
numberOfStimuli = 8;
stimRan = randperm(numberOfStimuli);

count = 1;
stim.state = state{1};
repeat = 1;

while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    [stim,currentCommand] = pickStimulus(trialMeta.stimNum,sampRate,injectionDur,state);
    fprintf(['\nMake sure state is ',stim.state])
    pause
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



function [stim,currentCommand] = pickStimulus(stimNum,sampRate,injectionDur,state)
switch stimNum
    case 1 % stimulus, no current injection
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 1; 
        stim.state = state{1};
        stim.endPadDur = 5; 
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
    case 2 % stimulus with smaller post-stimulus current injection
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 1; 
        stim.state = state{1};
        stim.endPadDur = 5; 
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (stim.startPadDur+stim.stimDur)*sampRate;
        pulseEndInd = (stim.startPadDur+stim.stimDur+injectionDur)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 3*(-0.0394/4);
    case 3 % stimulus with larger post-stimulus current injection
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 1; 
        stim.state = state{1};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (stim.startPadDur+stim.stimDur)*sampRate;
        pulseEndInd = (stim.startPadDur+stim.stimDur+injectionDur)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 6*(-0.0394/4);
    case 4 % without a stimulus, with current injection
        stim = OptoStimulus;
        stim.optoDur = 1; 
        stim.state = state{2};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (3)*sampRate;
        pulseEndInd = (3+injectionDur)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 3*(-0.0394/4);
    case 5 % without a stimulus, with larger current injection
        stim = OptoStimulus;
        stim.optoDur = 1; 
        stim.state = state{2};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (3)*sampRate;
        pulseEndInd = (3+injectionDur)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 6*(-0.0394/4);
    case 6 % without a stimulus, +ve current injection 
        stim = OptoStimulus;
        stim.optoDur = 1; 
        stim.state = state{2};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (3)*sampRate;
        pulseEndInd = (3+injectionDur*sampRate);
        currentCommand(pulseStartInd:pulseEndInd) = 3*(0.0394/4);
    case 7 % without a stimulus with larger +ve current injection
        stim = OptoStimulus;
        stim.optoDur = 1; 
        stim.state = state{2};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (3)*sampRate;
        pulseEndInd = (3+injectionDur)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 6*(0.0394/4);
    case 8 % current injection during stimulus 
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 1; 
        stim.state = state{1};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (2)*sampRate;
        pulseEndInd = (3)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 6*(-0.0394/4);    
end
end







