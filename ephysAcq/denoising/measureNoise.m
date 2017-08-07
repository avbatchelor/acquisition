function measureNoise(channel)


%% Acquire two second trial 
stim = noStimulus;
stim.waveDur = 2; 
exptInfo.stimType = 's';
trialMeta.stimNum = 1;
switchSpeaker(stim.speaker);
[data, settings] = acquireTrial('i',stim,exptInfo,[],trialMeta);

%% Select current or voltage 
if strcmp(channel,'i')
    fftData = data.current;
else
    fftData = data.voltage;
end

%% Fourier transform 
[pfft, fVals] = getFreqContent(data.current,settings.sampRate.in);

%% FFT Plot 
fftPlot(pfft,fVals)

        





