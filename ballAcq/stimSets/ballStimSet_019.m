function ballStimSet_019(exptInfo)

% No stimulus, minute long trials

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
stim = noStimulus; 
stim.startPadDur = 5; 
stim.endPadDur = 5; 
trialMeta.stimNum = 1; 
trialMeta.outputCh = stim.speakerChannel;
count = 1; 
while count < 11
    acquireBallTrial(stim,exptInfo,trialMeta);
    count = count + 1; 
    pause;
end
