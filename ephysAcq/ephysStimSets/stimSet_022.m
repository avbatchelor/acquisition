function stimSet_022(exptInfo,preExptData)

% Pure 250Hz tones with post-stimulus hyperpolarising currents

%% Hard-coded params 
injectionDur = 1.25;

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Load settings
ephysSettings;
sampRate = settings.sampRate.out;

%% Set up and acquire with the stimulus set
numberOfStimuli = 3;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    [stim,currentCommand] = pickStimulus(trialMeta.stimNum,sampRate,injectionDur);
    switchSpeaker(stim.speaker);
    acquireTrial('none',stim,exptInfo,preExptData,trialMeta,currentCommand);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
        repeat = repeat + 1;
    else
        count = count+1;
    end
end

end

function [stim,currentCommand] = pickStimulus(stimNum,sampRate,injectionDur)
switch stimNum
    case 1 % stimulus, no current injection
        % Make stimulus
        stim = SineWave;
        stim.carrierFreqHz = 110;
        stim.maxVoltage = 0.64;
        stim.endPadDur = 10;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
    case 2 % stimulus with smaller post-stimulus current injection
        % Make stimulus
        stim = SineWave;
        stim.carrierFreqHz = 110;
        stim.maxVoltage = 0.64;
        stim.endPadDur = 10;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (stim.startPadDur+stim.stimDur)*sampRate;
        pulseEndInd = (stim.startPadDur+stim.stimDur+injectionDur)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 1*(-0.0394/4);
    case 3 % stimulus with larger post-stimulus current injection
        % Make stimulus
        stim = SineWave;
        stim.carrierFreqHz = 110;
        stim.maxVoltage = 0.64;
        stim.endPadDur = 10;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (stim.startPadDur+stim.stimDur)*sampRate;
        pulseEndInd = (stim.startPadDur+stim.stimDur+injectionDur)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 2*(-0.0394/4);
    case 4 % without a stimulus, with current injection
        stim = noStimulus;
        stim.waveDur = 13;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (9)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 1*(-0.0394/4);
    case 5 % without a stimulus, with larger current injection
        stim = noStimulus;
        stim.waveDur = 13;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (9)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 2*(-0.0394/4);
    case 6 % without a stimulus, +ve current injection 
        stim = noStimulus;
        stim.waveDur = 13;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (9*sampRate);
        currentCommand(pulseStartInd:pulseEndInd) = 2*(0.0394/4);
    case 7 % without a stimulus with larger +ve current injection
        stim = noStimulus;
        stim.waveDur = 13;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (9)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 1*(0.0394/4);
    case 8 % no stimulus and no current injection 
        stim = noStimulus;
        stim.waveDur = 13;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
    case 9 % current injection during stimulus 
        % Make stimulus
        stim = SineWave;
        stim.carrierFreqHz = 110;
        stim.maxVoltage = 0.64;
        stim.endPadDur = 10;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (stim.startPadDur)*sampRate;
        pulseEndInd = (stim.startPadDur+stim.stimDur)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 2*(-0.0394/4);    
end
end




