function ballStimSet_019(exptInfo)

% For calibrating arduino sensor.  No stimulus, 10 second long trials

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
stim = noStimulus; 
stim.startPadDur = 2; 
stim.endPadDur = 2.3; 
trialMeta.stimNum = 1; 
trialMeta.outputCh = stim.speakerChannel;
count = 1; 
while count < 1000
    acquireBallTrial(stim,exptInfo,trialMeta);
    count = count + 1; 
end
