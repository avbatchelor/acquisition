function data = runPV_speaker(exp_info)


%% make a directory if one does not exist
fileName = (['C:\Users\Allison Baker\Electrophysiology\SpeakerPVmeas\SpeakerPVmeas_',date]);
if ~isdir(fileName)
    mkdir(fileName);
end

%% access data structure and count trials
% check whether a saved data file exists with today's date
D = dir([fileName,'\SpeakerPVmeas_',date,'.mat']);
if isempty(D)
    % if no saved data exists then this is the first trial
    n=1;
    disp(n);
else
    %load current data file
    load([fileName,'\SpeakerPVmeas_',date,'.mat']','data');
    n = length(data)+1;
    disp(n);
end

%% assign default values of input parameters
if nargin < 5, igortoggle = 0; end

% experiment information
data(n).date = date;                                % experiment date
data(n).trial = n;                                  % trial number
data(n).sampratein = 10000;                         % input sample rate
data(n).samprateout = 40000;                        % output sample rate
data(n).fc = exp_info.fc;                           % carrier frequency or F0 for FM sweep
data(n).fm = exp_info.fm;                           % modulation frequency (in Hz)
data(n).preamp_gain = 500;                          % gain on preamplifier
data(n).KE_sf = 3.2e-4;                             % KE particle velocity microphone (#2) sensitivity factor at 200 Hz
data(n).stimName = exp_info.stimName;
data(n).stimonset = .5;
data(n).stimpost = .5;
data(n).stimdur = exp_info.stim_dur;
data(n).intensity = exp_info.intensity;

% generate stimuli
if strcmp(data(n).stimName,'Courtship Song')
    stimtrain = wavread('C:\Users\Allison Baker\Electrophysiology\EPhys_Codes\CourtshipSong.wav');
    data(n).stimdur = length(stimtrain)/data(n).samprateout;
    intensity = data(n).intensity;
    stimtrain = intensity*stimtrain;
else
    [stimtrain intensity] = generateStim(data,n);
end

% timing calculations
data(n).stimonsamp = floor(data(n).stimonset*data(n).samprateout)+1;
data(n).stimoffsamp = floor(data(n).stimonset*data(n).samprateout)+(data(n).samprateout*data(n).stimdur);
data(n).nsampout = data(n).stimoffsamp+floor(data(n).stimpost*data(n).samprateout);
data(n).nsampin = ceil(data(n).nsampout/data(n).samprateout*data(n).sampratein);

stim = zeros(data(n).nsampout,1);
stim(data(n).stimonsamp:data(n).stimoffsamp) = stimtrain; %stimulus

% make sure stim is a column vector
if size(stim,1)==1; stim=stim'; end

data(n).trigdiff = 0;    % time between input and output triggers



%% run data acquisition
AI = exp_info.AI; AO = exp_info.AO; 

ch0out = [stim;zeros(100,1)];
ch1out = zeros(length(ch0out),1);
putdata(AO,[ch0out, ch1out]);

%% run trial
% start playback
start([AI AO]);
trigger([AI AO]);

% wait for playback/recording to finish
nsampin = AI.SamplesAcquired;
nsampout = AO.SamplesOutput;
while (nsampin<data(n).nsampin)
    nsampin = AI.SamplesAcquired;
    nsampout = AO.SamplesOutput;
end

% stop playback
stop([AI AO]);

% record difference in AI/AO start times
data(n).trigdiff = AO.InitialTriggerTime-AI.InitialTriggerTime;
    
% read data from engine
x = getdata(AI,data(n).nsampin);
KEraw = x(:,1);

% calculate particle velocity using sensitivity factor and pre-amp gain
t = [1:length(KEraw)]./data(n).sampratein;
pv = cumtrapz(t,(KEraw-mean(KEraw(1:500)))./data(n).preamp_gain)./data(n).KE_sf;


%% save data(n)
save([fileName,'\SpeakerPVmeas_',date],'data');
save([fileName,'\SpeakerPVmeasRaw_',date,'_',num2str(n)],'KEraw','pv','stim');

%% plot output
plotData(data,KEraw,pv,stim,n);

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plotData
function plotData(data,KEraw,pv,stim,n)

figure(2); scrsz = get(0,'ScreenSize');
set(gcf,'Position',[50 scrsz(4)/5 scrsz(3)-100 scrsz(4)/1.5]);
set(gcf,'PaperPositionMode','auto');
t_in=[1:data(n).nsampin]'/data(n).sampratein;
t_out = [1:data(n).nsampout]'/data(n).samprateout;

subplot(3,1,1); plot(t_in,KEraw,'r','lineWidth',1); ylabel('raw KE (V)');
xlim([0 max(t_in)]); 
ylim([min(KEraw)-.1*max(KEraw) max(KEraw)+.1*max(KEraw)]);
box off; set(gca,'TickDir','out');

subplot(3,1,2); plot(t_in,pv,'color',[.7 0 .5]); ylabel('particle vel. (m/s)');
xlim([0 max(t_in)]); box off; set(gca,'TickDir','out');
ylim([min(pv)-.1*max(pv) max(pv)+.1*max(pv)]);

disp(['stim = ',num2str(length(stim))]);
subplot(3,1,3); plot(t_out,stim,'c','lineWidth',2); ylabel('stim');
xlim([0 max(t_out)]);
box off; set(gca,'TickDir','out');
set(gca,'Ylim',[min(stim)-(.1*max(stim)) max(stim)+(.1*max(stim))]);
xlabel('time (seconds)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% function [stimtrain intensity] = generateStim(data,n);
function [stimtrain, intensity] = generateStim(data,n)

AMtrain = amp_mod(1,data(n).fm,data(n).fc,.5,...
    data(n).samprateout,data(n).stimdur,1,'with carrier');
if isempty(AMtrain)
    fprintf('AM stimulus not generated');
    return;
end
intensity = data(n).intensity; % set voltage scaling factor for stimulus output
stimtrain = intensity.*AMtrain';  % make sure stim is a column vector

