function twoPhotonStimSet_004(trialMeta)

% Goes through an array of speaker stimuli for the two photon

blockNum = newBlock;

%% Set up and acquire with the stimulus set
pause on
numberOfStimuli = 3;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 100
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum,blockNum);
    switchSpeaker(stim.speaker);
    playSound(stim);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
        repeat = repeat + 1;
    else
        count = count+1;
    end
end

end

function stim = pickStimulus(stimNum,blockNum)
switch stimNum
    case 1
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 1; 
        stim.endPadDur = 3; 
        stim.numPips = 60;
        switchBlock(blockNum+stimNum-1,'pip')
    case 2
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage = 0.5; 
        stim.endPadDur = 3;
        switchBlock(blockNum+stimNum-1,'ascending chirp')
    case 3
        stim = Chirp;
        stim.startFrequency  = 1500;
        stim.endFrequency    = 90;
        stim.maxVoltage = 0.5; 
        stim.endPadDur = 3;
        switchBlock(blockNum+stimNum-1,'descending chirp')
end
end




