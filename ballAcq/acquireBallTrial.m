function acquireBallTrial(stim,exptInfo,trialMeta)

fprintf('\n*********** Acquiring Trial ***********') 

%% Trial time 
trialMeta.trialStartTime = datestr(now,'HH:MM:SS'); 
fprintf(['\nTrial start time: ',trialMeta.trialStartTime]);

%% Create stimulus if needed  
if ~exist('stim','var')
    stim = noStimulus; 
end

stimMat = zeros(4,length(stim.stimulus));
stimMat(trialMeta.outputCh,:) = stim.stimulus;

%% Load settings    
settings = ballSettings; 
     
%% Configure session
s = daq.createSession('ni');
s.Rate = settings.sampRate;
s.DurationInSeconds = stim.totalDur;

% Add analog output channels (speaker)
s.addAnalogOutputChannel(settings.devID,'Voltage');

% Add analog input channels (sensor data)
aI = s.addAnalogInputChannel(settings.devID,settings.inChannelsUsed,'Voltage');
for i = 1+settings.inChannelsUsed
    aI(i).InputType = settings.aiType;
end

%% Run trials
s.queueOutputData(stimMat);
rawData = s.startForeground;

%% Close daq objects
s.stop;
s.stop;

%% Allocate data 
data.xVel = rawData(:,1);
data.yVel = rawData(:,2);
data.stimCommand0 = rawData(:,3);
data.stimCommand1 = rawData(:,4);

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



%% Plot data
plotBallData(Stim,rawData,trialMeta,exptInfo) 




end
