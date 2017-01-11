function stimSet_025(exptInfo,preExptData)

% Play a range of pure tones with different volumes through middle speaker

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Hard coded parameters
voltage = [0.04,0.08,0.16];
carrierRange = 50:50:450;
numberOfStimuli = length(voltage)*length(carrierRange);
numFreq = length(carrierRange);

%% Set up and acquire with the stimulus set
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum,voltage,carrierRange,numFreq);
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

function stim = pickStimulus(stimNum,voltage,carrierRange,numFreq)
switch stimNum
    case num2cell(1:numFreq)
        stimNumStart = 1;
        carrierInd = stimNum-stimNumStart+1;
        stim = SineWave;
        stim.carrierFreqHz = carrierRange(carrierInd);
        stim.maxVoltage = voltage(1);
    case num2cell(numFreq+1:numFreq*2)
        stimNumStart = numFreq+1;
        carrierInd = stimNum-stimNumStart+1;
        stim = SineWave;
        stim.carrierFreqHz = carrierRange(carrierInd);
        stim.maxVoltage = voltage(2);
    case num2cell(numFreq*2+1:numFreq*3)
        stimNumStart = numFreq*2+1;
        carrierInd = stimNum-stimNumStart+1;
        stim = SineWave;
        stim.carrierFreqHz = carrierRange(carrierInd);
        stim.maxVoltage = voltage(3);
end
end




