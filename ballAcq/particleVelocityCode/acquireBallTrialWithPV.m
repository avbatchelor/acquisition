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
data.acqStim1 = rawData(:,2);
% data.acqStim2 = rawData(:,3);
startPadEndIdx = (stim.startPadDur*stim.sampleRate)-1;
data.pv = cumtrapz(stim.timeVec,(data.KEraw-mean(data.KEraw(1:startPadEndIdx)))./settings.preamp_gain)./settings.KE_sf;

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
    Stim.class = class(stim);
    save(fileName, 'data','trialMeta','Stim','exptInfo');
    
    % Save expt data 
    if trialMeta.trialNum == 1
        settingsFileName = [path,fileNamePreamble,'exptData.mat'];
        save(settingsFileName,'settings','exptInfo'); 
    end
end

%% Filter signal
d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',55,'HalfPowerFrequency2',65, ...
               'DesignMethod','butter','SampleRate',settings.sampRate);

filteredSignal = filtfilt(d,data.KEraw);
%% Plot data
figure(1) 
subplot(3,1,1)
plot(Stim.timeVec,data.acqStim1)
subplot(3,1,2)
plot(Stim.timeVec,data.KEraw)
subplot(3,1,3)
plot(Stim.timeVec,1000*data.pv,'b')
ylabel('Particle velocity (mm/s)')
% hold on 
% plot(Stim.timeVec,filteredSignal,'r')

end
