function stimSet_025(exptInfo,preExptData)

% Play a range of pure tones with different volumes through middle speaker

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 9;
voltage = [0.02,0.04,0.08];

stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum);
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

function stim = pickStimulus(stimNum,voltage)
switch stimNum
    case num2cell(1:5)
        stimNumStart = 1;
        carrierInd = stimNum-stimNumStart+1;
        stim = SineWave;
        carrierRange = 100+(0:4).*50;
        stim.carrierFreqHz = carrierRange(carrierInd);
        stim.maxVoltage = voltage(1);
    case num2cell(6:10)
        stimNumStart = 6;
        carrierInd = stimNum-stimNumStart+1;
        stim = SineWave;
        carrierRange = 100+(0:4).*50;
        stim.carrierFreqHz = carrierRange(carrierInd);
        stim.maxVoltage = voltage(2);
    case num2cell(11:15)
        stimNumStart = 11;
        carrierInd = stimNum-stimNumStart+1;
        stim = SineWave;
        carrierRange = 100+(0:4).*50;
        stim.carrierFreqHz = carrierRange(carrierInd);
        stim.maxVoltage = voltage(3);
end
end




