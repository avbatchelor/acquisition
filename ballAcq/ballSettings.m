function settings = ballSettings

%% Acquisition settings
settings.sampRate = 40e3;
settings.devID = 'Dev3';
settings.inChannelsUsed = 0:3;

%% Processing settings
settings.xMinVal = 0.0348;
settings.xMaxVal = 4.8947;
settings.yMinVal = 0.0347;
settings.yMaxVal = 4.8845;
settings.xMidVal = 2.4582; 
settings.yMidVal = 2.4586;
% settings.xMidVal = 2.4654;
% settings.yMidVal = 2.4655;
settings.numInts = 271;
settings.cutoffFreq = 50;
settings.aiType = 'SingleEnded';
settings.outChannelsUsed = 0:3; 

settings.sensorRes  = 8200;
settings.mmConv = 25.4;
settings.mmPerCount = settings.mmConv/settings.sensorRes;
settings.sensorPollFreq = 100; 

computer = getComputerID;
if strcmp(computer,'behavior')
    settings.dataDirectory = 'C:\Users\Alex\Documents\Data\ballData\';
elseif strcmp(computer,'desktop')
    settings.dataDirectory = 'D:\ManuscriptData\rawData\';
elseif strcmp(computer,'laptop')
    settings.dataDirectory = 'D:\ManuscriptData\rawData\';
end

