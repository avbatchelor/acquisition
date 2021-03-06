function stimSet_005(exptInfo,preExptData)

% Pips, chirp, courtship song and pulse song from middle speaker

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 4;
stimRan = randperm(numberOfStimuli);

count = 1;
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
    else
        count = count+1;
    end
end

FS.Clear() ;  % Clear up the box
clear FS ;

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.speaker = 2;           
            case 2
                stim = Chirp;
                stim.speaker = 2;
            case 3
                stim = CourtshipSong;
                stim.speaker = 2;           
            case 4
                stim = PulseSong;
                stim.speaker = 2;
        end
    end


end
