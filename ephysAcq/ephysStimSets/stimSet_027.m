function stimSet_027(exptInfo,preExptData)

% Stim set for adding blockers

%% Archive this code
archiveExpCode(exptInfo)

%% Specify stimulus 
stim = SineWave;
stim.carrierFreqHz = freqRange(freqNum);
stim.maxVoltage = 0.1;

%% Set up and acquire with the stimulus set 
repeat = 1;
trialMeta.stimNum = 1;
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    repeat = runTrial(stim,preExptData,exptInfo,trialMeta,repeat);
end
FS.Clear() ;  % Clear up the box
clear FS ;

%% Add blockers
% Ask which blockers
prompt = {'Drug added:','Drug concentration:'};
dlg_title = 'Pharmacology info';
num_lines = 1;
defaultans = {'TTX','20 microMolar'};
dlgOut = inputdlg(prompt,dlg_title,num_lines,defaultans);
exptInfo.drugAdded = dlgOut(1);
exptInfo.drugConc = dlgOut(2);

% Run trials
trialMeta.stimNum = 2;
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    repeat = runTrial(stim,preExptData,exptInfo,trialMeta,repeat);
end
FS.Clear() ;  % Clear up the box
clear FS ;

end

function repeat = runTrial(stim,preExptData,exptInfo,trialMeta,repeat)
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    switchSpeaker(stim.speaker);
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    repeat = repeat + 1;
end
