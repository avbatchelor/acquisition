function [velMm,disp,seq,seqRound] = processBallData(rawData,stim,ballAxis)

settings = ballSettings;

%% Low-pass filter 50Hz cutoff
rate = 2*(settings.cutoffFreq/settings.sampRate);
[kb, ka] = butter(2,rate);
smoothedData = filtfilt(kb, ka, rawData);

%% Get mid, min and max val 
if strcmp(ballAxis,'x')
    minVal = settings.xMinVal; 
    midVal = settings.xMidVal;
    maxVal = settings.xMaxVal; 
else 
    minVal = settings.yMinVal; 
    midVal = settings.yMidVal;
    maxVal = settings.yMaxVal; 
end

% midVal = (maxVal-minVal)/2;


%% Discretize 
% Calculate volts per step 
voltsPerStep = (maxVal - minVal)/(settings.numInts - 1);

% Subtract minimum value and divide by volts per step 
seq = (smoothedData - midVal)./voltsPerStep;
%seq = (smoothedData - minVal)./voltsPerStep;

% Convert velocity to mm/s
velMm = seq.*settings.mmPerCount.*settings.sensorPollFreq;

%% Calculate displacement 
if exist('stim','var')
    % Integrate to calcuate displacement 
    disp = cumtrapz(stim.timeVec,velMm);

    % Set 0 displacement to stimulus start
    stimStartInt = stim.startPadDur*stim.sampleRate +1; 
    disp = disp - disp(stimStartInt,1);
else 
    disp = [];
end

%% Discretize
seqRound = round(seq);

% Make sure steps don't go out of range 
maxInt = (settings.numInts -1)/2;
seqRound(seqRound>maxInt) = maxInt;
seqRound(seqRound<-maxInt) = -maxInt;

% Center at 0
% zeroVal = -1 + (settings.numInts + 1)/2;
% Zeroedseq = seq - zeroVal;

%% Check 
% Check discretisation
% seqUnrounded = (rawData - minVal)./voltsPerStep;
% seqUnrounded = seqUnrounded - zeroVal;
% seqUnroundedSmoothed = (smoothedData - minVal)./voltsPerStep;
% seqUnroundedSmoothed = seqUnroundedSmoothed - zeroVal;


%     figure
%     plot(seqUnrounded,'r')
%     hold on
%     plot(seqUnroundedSmoothed,'b')
%     hold on
%     plot(seq,'g')
%     title(['Check discretisation',axis,' axis'])



end