function [data,settings,stim,trialMeta,exptInfo] = acquireLDVTrial(stim,exptInfo,trialMeta,varargin)

fprintf('\n*********** Acquiring Trial ***********')

%% Get trial number
% Get filename
fileDir = ['C:\Users\Alex\Documents\Data\',exptInfo.prefixCode,'\expNum',num2str(exptInfo.expNum,'%03d'),...
    '\flyNum',num2str(exptInfo.flyNum,'%03d')];
fileName = [fileDir,'\',exptInfo.prefixCode,'_expNum',num2str(exptInfo.expNum,'%03d'),...
    '_flyNum',num2str(exptInfo.flyNum,'%03d'),'_flyExpNum',num2str(exptInfo.flyExpNum,'%03d'),'.mat'];
if exist(fileName,'file')
    load(fileName) 
    n = length(data) + 1; 
else 
    n = 1; 
end
fprintf(['\nTrial Number = ',num2str(n)]);

%% Trial time
trialMeta(n).trialStartTime = datestr(now,'HH:MM:SS');

%% Code stamp
exptInfo.codeStamp      = getCodeStamp(1);

%% Create stimulus if needed
if ~exist('pulseType','var')
    pulseType = 'none';
end

if ~exist('stim','var')
    stim = noStimulus;
end

%% Load settings
settings = ldvSettings(stim);


%% Configure daq
daqreset;


%% Configure analog output
AO = analogoutput ('nidaq', 'Dev1');
addchannel (AO, 0);
set(AO, 'SampleRate', settings.sampRate.out);
set(AO, 'TriggerType', 'Manual');
putdata(AO,stim.stimulus)

%% Configure analog input
AI = analoginput ('nidaq', 'Dev1');
addchannel (AI, 0);
set(AI, 'SampleRate', settings.sampRate.in);
set(AI, 'SamplesPerTrigger', inf);
set(AI, 'InputType', 'Differential');
set(AI, 'TriggerType', 'Manual');
set(AI, 'ManualTriggerHwOn','Trigger');

%% Run trials
% start playback
start([AI AO]);
trigger([AI AO]);

% wait for playback/recording to finish
nsampin = AI.SamplesAcquired;
nsampout = AO.SamplesOutput;
while (nsampin<data(n).nsampin)
    data(n).nsampin = AI.SamplesAcquired;
    data(n).nsampout = AO.SamplesOutput;
end

% stop playback
stop([AI AO]);

% record difference in AI/AO start times
data(n).trigdiff = AO.InitialTriggerTime-AI.InitialTriggerTime;

% read data from engine
x = getdata(AI,data(n).nsampin);
data(n).ldvVoltage = x(:,1);
data(n).velocity = (settings.ldvGain.*data(n).ldvVoltage)';  % acquire voltage output from LDV and convert to velocity (channel ACH0)
velocity_subtracted = velocity - mean(velocity);
data(n).displacement = 10^3.*(1/(settings.sampRate.in).*cumsum(velocity_subtracted));  % displacement is integral of velocity (times 10^6 to get um from mm)


%% Only if saving data
% Convert stim object to structure for saving
warning('off','MATLAB:structOnObject')
Stim(n) = struct(stim);
save(fileName, 'data','settings','trialMeta','Stim','exptInfo');


%% Plot data
plotLDVData(stim,settings,data)




end

%% plotData
function plotLDVData(data,velocity,displacement,stim,n)

figure(1); 
scrsz = get(0,'ScreenSize');
set(gcf,'Position',[50 scrsz(4)/5 scrsz(3)-100 scrsz(4)/1.5]);
set(gcf,'PaperPositionMode','auto');
t_in=[1:data(n).nsampin]'/settings.sampRate.in;
t_out = [1:data(n).nsampout]'/settings.sampRate.out;

subplot(3,1,1); 
plot(t_in,velocity,'r','lineWidth',1); 
ylabel('velocity (mm/s)');
set(gca,'Xlim',[0 max(t_in)]); %ylim([min(voltage)-.33*max(voltage) max(voltage)+.33*max(voltage)]);
ylim([min(velocity)-.1*max(velocity) max(velocity)+.1*max(velocity)]);
box off; 
set(gca,'TickDir','out');

subplot(3,1,2); 
plot(t_in,displacement,'color',[1 0 .5]); 
ylabel('displacement (um)');
xlim([0 max(t_in)]); 
box off; 
set(gca,'TickDir','out');

disp(['t_out = ',num2str(length(t_out))]); 
disp(['stim = ',num2str(length(stim))]);

subplot(3,1,3); 
plot(t_out,stim,'c','lineWidth',2); 
ylabel('stim');
xlim([0 max(t_out)]);
box off; 
set(gca,'TickDir','out');
set(gca,'Ylim',[min(stim)-(.1*max(stim)) max(stim)+(.1*max(stim))]);
xlabel('time (seconds)');

end