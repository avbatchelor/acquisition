function sumData = sumBallData2(procData,trialMeta,exptInfo,stim)

% same as sumBallData but collects average speed for each trial rather than
% making a histogram of speed

%% Get summmary data filename
trialNum = trialMeta.trialNum;
[~, path, fileNamePreamble, ~] = getDataFileNameBall(exptInfo);
fileName = [path,fileNamePreamble,'onlineSumData.mat'];

%% Find average 
if trialNum ~= 1
    load(fileName)
else 
    sumData.stimNum = [];
end 

if ~any(sumData.stimNum == trialMeta.stimNum)     % If there are no trials for this stim before, average = this trial       
    sumData.byStim(trialMeta.stimNum).meanXDisp = procData.disp(:,1);
    sumData.byStim(trialMeta.stimNum).meanYDisp = procData.disp(:,2);
    sumData.byStim(trialMeta.stimNum).description = stim.description;
else 
    numTrials = sum(sumData.stimNum == trialMeta.stimNum);
    sumData.byStim(trialMeta.stimNum).meanXDisp = (numTrials*sumData.byStim(trialMeta.stimNum).meanXDisp + procData.disp(:,1))./(numTrials+1);
    sumData.byStim(trialMeta.stimNum).meanYDisp = (numTrials*sumData.byStim(trialMeta.stimNum).meanYDisp + procData.disp(:,2))./(numTrials+1);
end

%% Calculate resultant speed for that trial
sumData.meanTrialSpeed(trialNum) = mean(sqrt((procData.vel(:,1).^2)+(procData.vel(:,2).^2)));

%% Get sequence of stim numbers
sumData.stimNum(trialNum) = trialMeta.stimNum;

%% Save data
save(fileName, 'sumData');
