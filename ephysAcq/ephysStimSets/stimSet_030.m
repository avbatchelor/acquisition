function stimSet_030(exptInfo,preExptData)

% Sine wave with and without CVA 

%% Speaker or piezo 
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Run current injection trial
currentInjectionTrial(exptInfo,preExptData)

%% Set up and acquire with the stimulus set
count = 1;
stimCount = 1;
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimCount;
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    if count == 1
        fprintf(['Make sure odor is ',stim.odor,'\n'])
        pause
    end
    acquireTrial('none',stim,exptInfo,preExptData,trialMeta);
    if count == 3
        count = 1;
        stimCount = stimCount + 1;
    else
        count = count+1;
    end
    if stimCount == 3
        stimCount = 1;
        repeat = repeat + 1;
    end
end

%% Run current injection trial
currentInjectionTrial(exptInfo,preExptData)


end



function stim = pickStimulus(stimNum)
switch stimNum
    case 1
        stim = SineWave;
        stim.speaker = 2;
        stim.carrierFreqHz = 150; 
        stim.maxVoltage =0.16;
        stim.endPadDur = 30;
        stim.odor = 'filter paper only';
    case 2
        stim = SineWave;
        stim.speaker = 2;
        stim.carrierFreqHz = 150; 
        stim.maxVoltage =0.16;
        stim.endPadDur = 30;
        stim.odor = 'filter paper plus CVA';
        %     case 1
        %         stim = PipStimulus;
        %         stim.speaker = 2;
        %         stim.maxVoltage = 0.32;
        %         stim.carrierFreqHz = 220;
        %         stim.ipi = 0.035;
        %         stim.odor = 'filter paper only';
        %         stim.pipDur = 3*(1/stim.carrierFreqHz);
        %         stim.envelopeRamp = 2;
        %     case 2
        %         stim = PipStimulus;
        %         stim.speaker = 2;
        %         stim.maxVoltage = 0.32;
        %         stim.carrierFreqHz = 220;
        %         stim.ipi = 0.035;
        %         stim.odor = 'filter paper plus CVA';
        %         stim.pipDur = 3*(1/stim.carrierFreqHz);
        %         stim.envelopeRamp = 2;
end
end




