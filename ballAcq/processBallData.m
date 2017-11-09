function [velMm,disp,seq,seqRound] = processBallData(rawData,minVal,maxVal,settings,stim)

%% Low-pass filter 50Hz cutoff
rate = 2*(settings.cutoffFreq/settings.sampRate);
[kb, ka] = butter(2,rate);
smoothedData = filtfilt(kb, ka, rawData);

%% Discretize 
% Calculate volts per step 
voltsPerStep = (maxVal - minVal)/(settings.numInts - 1);

midVal = (maxVal-minVal)/2;
% Subtract minimum value and divide by volts per step 
seq = (smoothedData - midVal)./voltsPerStep;
%seq = (smoothedData - minVal)./voltsPerStep;

seqRound = round(seq);

% Make sure steps don't go out of range 
maxInt = (settings.numInts -1)/2;
seqRound(seqRound>maxInt) = maxInt;
seqRound(seqRound<-maxInt) = -maxInt;

% Center at 0
% zeroVal = -1 + (settings.numInts + 1)/2;
% Zeroedseq = seq - zeroVal;

%% Convert to correct units 
% Convert velocity to mm/s
velMm = seq.*settings.mmPerCount.*settings.sensorPollFreq;

% Integrate to calcuate displacement 
disp = cumtrapz(stim.timeVec,velMm);

% Set 0 displacement to stimulus start
stimStartInt = stim.startPadDur*stim.sampleRate +1; 
disp = disp - disp(stimStartInt,1);


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