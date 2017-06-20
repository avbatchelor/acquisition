function stimSet_022(exptInfo,preExptData)

% Pure 250Hz tones with post-stimulus hyperpolarising currents

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Load settings
ephysSettings;
sampRate = settings.sampRate.out;

%% Set up and acquire with the stimulus set
numberOfStimuli = 7;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    [stim,currentCommand] = pickStimulus(trialMeta.stimNum,sampRate);
    switchSpeaker(stim.speaker);
    acquireTrialWithCamera('none',stim,exptInfo,preExptData,trialMeta,currentCommand);
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
    case 1 % without post-stimulus current injection
        % Make stimulus
        stim = SineWave;
        stim.carrierFreqHz = 160;
        stim.maxVoltage = 0.32;
        stim.endPadDur = 30;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
    case 2 % with smaller post-stimulus current injection
        % Make stimulus
        stim = SineWave;
        stim.carrierFreqHz = 160;
        stim.maxVoltage = 0.32;
        stim.endPadDur = 30;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (stim.startPadDur+stim.stimDur)*sampRate;
        pulseEndInd = (stim.startPadDur+stim.stimDur+5)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 2*(-0.0394/4);
    case 3 % with larger post-stimulus current injection
        % Make stimulus
        stim = SineWave;
        stim.carrierFreqHz = 160;
        stim.maxVoltage = 0.32;
        stim.endPadDur = 30;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (stim.startPadDur+stim.stimDur)*sampRate;
        pulseEndInd = (stim.startPadDur+stim.stimDur+5)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 1*(-0.0394/4);
    case 4 % without a stimulus
        stim = noStimulus;
        stim.waveDur = 14;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (5)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 2*(-0.0394/4);
    case 5 % without a stimulus with larger current injection
        stim = noStimulus;
        stim.waveDur = 14;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (5)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 1*(-0.0394/4);
    case 6 % +ve current injection without a stimulus
        stim = noStimulus;
        stim.waveDur = 14;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (5*sampRate);
        currentCommand(pulseStartInd:pulseEndInd) = 2*(0.0394/4);
    case 7 % without a stimulus with larger +ve current injection
        stim = noStimulus;
        stim.waveDur = 14;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (4)*sampRate;
        pulseEndInd = (5)*sampRate;
        currentCommand(pulseStartInd:pulseEndInd) = 1*(0.0394/4);
end
end




