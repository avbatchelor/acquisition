function acquireBallTrialWithPV(stim,exptInfo,trialMeta)

fprintf('\n*********** Acquiring Trial ***********') 

%% Trial time 
trialMeta.trialStartTime = datestr(now,'HH:MM:SS'); 
fprintf(['\nTrial start time: ',trialMeta.trialStartTime]);

%% Create stimulus if needed  
if ~exist('stim','var')
    stim = noStimulus; 
end

%% Load settings    
settings = ballSettingsWithPV; 
     
%% Configure session
s = daq.createSession('ni');
s.Rate = settings.sampRate;
s.DurationInSeconds = stim.totalDur;

% Add analog output channels (speaker)
s.addAnalogOutputChannel(settings.devID,trialMeta.outputCh,'Voltage');

% Add analog input channels (sensor data)
aI = s.addAnalogInputChannel(settings.devID,settings.inChannelsUsed,'Voltage');
for i = 1:length(settings.inChannelsUsed)
    aI(i).InputType = settings.aiType;
end

%% Run trials
s.queueOutputData([stim.stimulus]);
rawData = s.startForeground;

%% Close daq objects
s.stop;
s.stop;

%% Allocate data 
data.KEraw = rawData(:,1);
data.acqStim = rawData(:,2);
startPadEndIdx = (Stim.startPadDur*Stim.sampleRate)-1;
data.pv = cumtrapz(Stim.timeVec,(KEraw-mean(KEraw(1:startPadEndIdx)))./settings.preamp_gain)./settings.KE_sf;

%% Only if saving data
if nargin ~= 0 && nargin ~= 1
    % Get filename and save trial data
    [fileName, path, fileNamePreamble, trialMeta.trialNum] = getDataFileNameBall(exptInfo);
    fprintf(['\nTrial Number ', num2str(trialMeta.trialNum)])
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    if ~isdir(path)
        mkdir(path);
    end
    % Convert stim object to structure for saving 
    warning('off','MATLAB:structOnObject')
    Stim = struct(stim); 
    save(fileName, 'data','trialMeta','Stim','exptInfo');
    
    % Save expt data 
    if trialMeta.trialNum == 1
        settingsFileName = [path,fileNamePreamble,'exptData.mat'];
        save(settingsFileName,'settings','exptInfo'); 
    end
end


%% Plot data
figure(1) 
subplot(2,1,1)
plot(Stim.timeVec,data.acqStim)
subplot(2,1,2)
plot(Stim.timeVec,data.pv)

end
