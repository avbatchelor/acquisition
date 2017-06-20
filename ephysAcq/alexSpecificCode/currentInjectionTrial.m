function currentInjectionTrial(exptInfo,preExptData)

trialMeta.stimNum = 0;
stim = noStimulus; 
stim.waveDur = 3;
acquireTrial('i',stim,exptInfo,preExptData,trialMeta);

end