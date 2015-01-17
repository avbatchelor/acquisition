function mergeTrials(prefixCode,expNum,flyNum,flyExpNum)

exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.flyExpNum      = flyExpNum;

%% load raw data and process (filter, interpolate, calculate velocity)
[~,path] = getDataFileName(exptInfo);
cd(path)
fileNames = dir('*trial*.mat');
numTrials = length(fileNames);

stimSequence = [];
% load and process data
for n = 1:numTrials;
    clear data stim meta
    load([path,fileNames(n).name]);
    
    %     trialNum = trailMeta.trialNum;
    stimNum = meta.stimNum;
    
    
    if any(stimSequence == stimNum)
    else
        %         dataLength    = length(data.voltage);
        %         stimLength    = length(stim.stimulus);
        %         GroupData(stimNum).current = NaN(numTrials,dataLength);
        %         GroupData(stimNum).voltage = NaN(numTrials,dataLength);
        GroupStim(stimNum).stimulus = stim.stimulus;
    end
    stimSequence = [stimSequence, meta.stimNum];
    trialInd = sum(stimSequence == stimNum);
    GroupData(stimNum).current(trialInd,:) = data.current;
    GroupData(stimNum).voltage(trialInd,:) = data.voltage;
    
    
    
end

%% save processed data
[~, path, ~, idString] = getDataFileName(exptInfo);
saveFileName = [path,idString,'groupedData.mat'];
save(saveFileName,'GroupData','GroupStim');