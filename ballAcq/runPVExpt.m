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
    %% Get data specific to particle velocity experiment 
    exptInfo.microphone = selectOption('microphone',{'KE1','KE2'});
    exptInfo.speaker = str2double(selectOption('speaker',{'1','2','3','4','5'}));
    exptInfo.ampGain = input('Enter amp gain: ');
    exptInfo.ampType = selectOption('amplifier type',{'Crown D-45','Crown XLS202','SLA 1'});
    exptInfo.ampVol = selectOption('amplifier vol',{'22, 16 notches','30, 15 notches'});
    exptInfo.ampNum = str2double(selectOption('amp Num',{'1','2','3'}));
    exptInfo.speakerDistance = str2double(selectOption('speaker distance in cm',{'22','27'}));
    exptInfo.ampChannel = str2double(selectOption('amp Channel Num',{'1','2'}));
end



%% Run experiment with stimulus
contAns = input('Would you like to start the experiment? ','s');
if strcmp(contAns,'y')
    fprintf('**** Running Experiment ****\n')
    eval(['ballStimSet_',num2str(stimSetNum,'%03d'),...
        '(exptInfo)'])
end

