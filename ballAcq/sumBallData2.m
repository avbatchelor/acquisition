function sumData = sumBallData2(procData,trialMeta,exptInfo)

% same as sumBallData but collects average speed for each trial rather than
% making a histogram of speed

%% Get summmary data filename
trialNum = trialMeta.trialNum;
[~, path, fileNamePreamble, ~] = getDataFileNameBall(exptInfo);
fileName = [path,fileNamePreamble,'onlineSumData.mat'];

%% Histogram settings
bins = -10:0.5:40;

%% Process and save data
if trialNum == 1
    sumData.byStim(trialMeta.stimNum).xDisp(:,1) = procData.disp(:,1);
    sumData.byStim(trialMeta.stimNum).yDisp(:,1) = procData.disp(:,2);
else
    load(fileName)
    if ~any(sumData.stimNum == trialMeta.stimNum)
        sumData.byStim(trialMeta.stimNum).xDisp = NaN(size(procData.disp(:,1)));
        sumData.byStim(trialMeta.stimNum).yDisp = NaN(size(procData.disp(:,1)));
    end
    sumData.byStim(trialMeta.stimNum).xDisp = nansum([sumData.byStim(trialMeta.stimNum).xDisp,procData.disp(:,1)],2);
    sumData.byStim(trialMeta.stimNum).yDisp = nansum([sumData.byStim(trialMeta.stimNum).yDisp,procData.disp(:,2)],2);
end

Vxy = sqrt((procData.vel(:,1).^2)+(procData.vel(:,2).^2));
sumData.trialSpeed(trialNum) = mean(Vxy);

sumData.stimNum(trialNum) = trialMeta.stimNum;
numTrials = sum(sumData.stimNum == trialMeta.stimNum);
sumData.byStim(trialMeta.stimNum).meanXDisp = sumData.byStim(trialMeta.stimNum).xDisp./numTrials;
sumData.byStim(trialMeta.stimNum).meanYDisp = sumData.byStim(trialMeta.stimNum).yDisp./numTrials;

save(fileName, 'sumData');