function settings = twoPhotonSettings(stim)

%% Parameters
% Samp Rate
settings.sampRate.out   = stim.sampleRate;
settings.sampRate.in    = stim.sampleRate;

% Break out box 
settings.bob.trigOut = 'port0/line0';
settings.bob.aiType = 'SingleEnded';
settings.bob.xMirrorCh = 5;
settings.bob.yMirrorCh = 6;
settings.bob.inChannelsUsed = 5:6; 
settings.bob.xMirrorCol = 1; 
settings.bob.yMirrorCol = 2; 

settings.devID = 'Dev3';


