function currentInjectionTrial(exptInfo,preExptData)

trialMeta.stimNum = 0;
stim = noStimulus; 
stim.waveDur = 3;
acquireTrialWithCamera('i',stim,exptInfo,preExptData,trialMeta);

end