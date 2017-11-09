function settings = ballSettings

%% Acquisition settings
settings.sampRate = 40e3;
settings.devID = 'Dev1';
settings.inChannelsUsed = 0:3;

%% Processing settings
settings.xMinVal = 0.0393;
settings.xMaxVal = 4.8994;
settings.yMinVal = 0.0392;
settings.yMaxVal = 4.8890;
settings.xMidVal = 2.4654;
settings.yMidVal = 2.4655;
settings.numInts = 271;
settings.cutoffFreq = 50;
settings.aiType = 'SingleEnded';
settings.outChannelsUsed = 6:7; % digital output for the olfactometer (TO)

settings.sensorRes  = 8200;
settings.mmConv = 25.4;
settings.mmPerCount = settings.mmConv/settings.sensorRes;
settings.sensorPollFreq = 100; 

settings.dataDirectory = 'C:\Users\Alex\Documents\Data\ballData\';

