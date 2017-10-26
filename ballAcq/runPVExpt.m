function runPVExpt(prefixCode,expNum,stimSetNum)

%% Get fly and experiment details from experimenter
newFly = input('New fly? ','s');
newFlyExp = input('New fly expt? ','s');
[flyNum, flyExpNum] = getFlyNumBall(prefixCode,expNum,newFly,newFlyExp);
fprintf(['Fly Number = ',num2str(flyNum),'\n'])
fprintf(['Fly Experiment Number = ',num2str(flyExpNum),'\n'])

%% Set meta data
exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.flyExpNum      = flyExpNum;
exptInfo.dNum           = datestr(now,'YYmmDD');
exptInfo.exptStartTime  = datestr(now,'HH:MM:SS'); 
exptInfo.stimSetNum     = stimSetNum; 
if strcmp(newFlyExp,'y')
    exptInfo.flyExpNotes = input('Fly Expt Notes: ','s');
end

%% Get data specific to particle velocity experiment 
exptInfo.microphone = selectOption({'KE1','KE2'});
exptInfo.speaker = str2double(selectOption({'1','2','3','4'}));
exptInfo.ampGain = input('Enter amp gain: ');

%% Run experiment with stimulus
contAns = input('Would you like to start the experiment? ','s');
if strcmp(contAns,'y')
    fprintf('**** Running Experiment ****\n')
    eval(['ballStimSet_',num2str(stimSetNum,'%03d'),...
        '(exptInfo)'])
end

