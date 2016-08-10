function stim = olfactometerPulse(trialMeta)
%%% generate pulse for driving the olfactometer
%%% Tatsuo Okubo
%%% 2016/05/06

settings = ballSettings;
Fs = settings.sampRate; % [Hz]

%% master valve for wind delivery
windPre = trialMeta.windPre;
odorPre = trialMeta.odorPre;
odorDur = trialMeta.odorDur;
odorPost = trialMeta.odorPost;
windPost = trialMeta.windPost;

windDur = odorPre+odorDur+odorPost; % [s]

trialDur = windPre+windDur+windPost; % [s]
windPulse = [zeros(round(windPre*Fs),1); ones(round(windDur*Fs),1); zeros(round(windPost*Fs),1)];
odorPulse = [zeros(round((windPre+odorPre)*Fs),1); ones(round(odorDur*Fs),1); zeros(round((odorPost+windPost)*Fs),1)];

Output(:,1) = windPulse; % master valve
Output(:,2) = odorPulse; % pinch valve

%% meta data
stim.stimulus = Output;
stim.totalDur = trialDur; % [s]
stim.timeVec = [0:length(Output)-1]./Fs; % [s]
stim.startPadDur = 0; % [s]
stim.windPre = windPre;
stim.odorPre = odorPre;
stim.odorDur = odorDur;
stim.odorPost = odorPost;
stim.windPost = windPost;
stim.endParDur = 0; % [s]
stim.sampleRate = Fs;
stim.stimDur = odorDur;

switch trialMeta.stimNum
    case 1
        stim.description = '0 deg';
    case 2
        stim.description = 'R 45 deg';
    case 3
        stim.description = 'R 90 deg';
    case 4
        stim.description = 'R 135 deg';
    case 5
        stim.description = '180 deg';        
    case 6
        stim.description = 'L 135 deg';
    case 7
        stim.description = 'L 90 deg';
    case 8
        stim.description = 'L 45 deg';
end