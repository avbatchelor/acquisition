function [data,settings,stim,trialMeta,exptInfo] = acquireTrialWithOdor(pulseType,stim,exptInfo,preExptData,trialMeta,varargin)

fprintf('\n*********** Acquiring Trial ***********') 

daqreset;

%% Trial time 
trialMeta.trialStartTime = datestr(now,'HH:MM:SS'); 

%% Code stamp
exptInfo.codeStamp      = getCodeStamp(mfilename('fullpath'));

%% Create stimulus if needed  
if ~exist('pulseType','var')  
    pulseType = 'none';
end

if ~exist('stim','var')
    stim = noStimulus; 
    stim.waveDur = 3; 
end


%% Load settings    
ephysSettings; 
     
%% Generate pulse
switch pulseType
    case 'none'
        settings.pulse.Amp = 0;
    case 'i'
        settings.pulse.Amp = -0.0394/4;
    case 'v'
        settings.pulse.Amp = -5/6;
end   

if ~exist('currentCommand','var')
    settings.pulse.Command = zeros(size(stim.stimulus));
    settings.pulse.Command(settings.pulse.Start:settings.pulse.End) = settings.pulse.Amp;
else 
    settings.pulse.Command = currentCommand; 
    settings.pulse.Command(settings.pulse.Start:settings.pulse.End) = settings.pulse.Amp;
end

%% Configure daq
% daqreset;
devID = 'Dev1';

%% Configure ouput session
s = daq.createSession('ni');
s.Rate = stim.sampleRate;
s.DurationInSeconds = stim.totalDur;

% Analog Channels / names for documentation
if isa(stim,'WindStimulus')
    s.addAnalogOutputChannel(devID,0,'Voltage'); % Current injection commmand
    s.addDigitalChannel('Dev1','port0/line4','OutputOnly');
    disp('Using wind stimulus')
    outputData = [settings.pulse.Command,stim.stimulus];
else 
    s.addAnalogOutputChannel(devID,0:1,'Voltage'); % Speaker/piezo command & current injection command
    outputData = [stim.stimulus,settings.pulse.Command];
end

% Add analog input channels 
aI = s.addAnalogInputChannel(devID,settings.bob.inChannelsUsed,'Voltage');
for i = 1:length(settings.bob.inChannelsUsed)
    aI(i).InputType = settings.bob.aiType;
end

%% Run trials
s.queueOutputData(outputData);
rawData = s.startForeground;


%% Decode telegraphed output
[trialMeta.scaledOutput.gain, trialMeta.scaledOutput.freq, trialMeta.mode] = decodeTelegraphedOutput(rawData,...
    settings.bob.gainCh+1,settings.bob.freqCh+1,settings.bob.modeCh+1);


%% Process and plot non-scaled data
% Process
data.voltage = settings.voltage.softGain .* rawData(:,settings.bob.voltCh+1);
data.current = settings.current.softGain .* rawData(:,settings.bob.currCh+1);
data.speakerCommand = rawData(:,settings.bob.speakerCommandCh+1);
data.piezoSG = rawData(:,settings.bob.piezoSGReading+1);

%% Process scaled data
% Scaled output
switch trialMeta.mode
    % Voltage Clamp
    case {'Track','V-Clamp'}
        trialMeta.scaledOutput.softGain = 1000/(trialMeta.scaledOutput.gain*settings.current.betaFront);
        data.scaledCurrent = trialMeta.scaledOutput.softGain .* rawData(:,settings.bob.scalCh+1);
        
    % Current Clamp
    case {'I=0','I-Clamp Normal','I-Clamp Fast'}
        trialMeta.scaledOutput.softGain = 1000/(trialMeta.scaledOutput.gain);
        data.scaledVoltage = trialMeta.scaledOutput.softGain .* rawData(:,settings.bob.scalCh+1);
        
end

%% Measure Access Resistance 
if pulseType == 'i'
    trialMeta.membraneResistance = measureMembraneResistance(data,settings);
end

%% Only if saving data
if nargin ~= 0 && nargin ~= 1
    % Get filename and save trial data
    [fileName,path,trialMeta.trialNum] = getDataFileName(exptInfo);
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
        [~, path, ~, idString] = getDataFileName(exptInfo);
        settingsFileName = [path,idString,'exptData.mat'];
        save(settingsFileName,'settings','exptInfo','preExptData'); 
    end
end

%% Close daq objects
s.stop;
s.stop;

%% Plot data
plotData(stim,settings,data)




end
