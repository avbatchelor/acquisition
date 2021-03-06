function twoPhotonStimSet_003(trialMeta)

% Array of piezo stimuli for the two photon 

blockNum = newBlock;

%% Set up and acquire with the stimulus set
pause on 
numberOfStimuli = 21;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 2
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum,blockNum);
    switchSpeaker(stim.speaker);
    metaFileName = acquireTwoPhotonTrial(stim,trialMeta);
    postMultTrialPlot(metaFileName,'Online')
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
        stim.maxVoltage = 4; 
        switchBlock(blockNum+stimNum-1,'pip')
    case 2
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
        stim.startFrequency  = 400;
        stim.endFrequency    = 17;
        stim.mode = 'piezo';
        switchBlock(blockNum+stimNum-1,'ascending chirp')
    case 3
        stim = Chirp;
        stim.startFrequency  = 17;
        stim.endFrequency    = 400;
        stim.maxVoltage = 4;
        stim.mode = 'piezo';
        switchBlock(blockNum+stimNum-1,'descending chirp')
    case 4
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
        switchBlock(blockNum+stimNum-1,'courtship song')
    case 5
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
        switchBlock(blockNum+stimNum-1,'pulse song')
    case 6
        stim = SquareWave;
        stim.speaker = 2;
        stim.maxVoltage = 4; 
        switchBlock(blockNum+stimNum-1,'square wave')
    case num2cell(7:16)
        freqRange = 25.*sqrt(2).^((-1:8));
        stimNumStart = 7-1;
        freqNum = stimNum - stimNumStart;
        stim = SineWave;
        stim.carrierFreqHz = freqRange(freqNum);
        stim.maxVoltage = 4; 
        switchBlock(blockNum+stimNum-1,['sine wave ',num2str(stim.carrierFreqHz),'Hz'])
    case num2cell(17:21)
        modFreqRange = 2.^(0:4);
        stimNumStart = 17-1;
        modFreqNum = stimNum - stimNumStart;
        stim = AmTone;
        stim.carrierFreqHz = 300;
        stim.modFreqHz = modFreqRange(modFreqNum);
        stim.maxVoltage = 4; 
        switchBlock(blockNum+stimNum-1,['AM Tone, 300Hz carrier, ',num2str(stim.modFreqHz),'Hz mod freq'])
end
end
