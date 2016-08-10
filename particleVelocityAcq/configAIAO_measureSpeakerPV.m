function [AI, AO] = configAIAO_measureSpeakerPV()

sampratein = 10000; samprateout = 40000;

% configure AI
AI = analoginput ('nidaq', 'Dev1');
addchannel (AI, 0);  % initializes channel A0 for particle velocity microphone input
set(AI, 'SampleRate', sampratein);
set(AI, 'SamplesPerTrigger', inf);
set(AI, 'InputType', 'Differential');
set(AI, 'TriggerType', 'Manual');
set(AI, 'ManualTriggerHwOn','Trigger');

% configure AO
AO = analogoutput ('nidaq', 'Dev1');
addchannel (AO, 0:1); % initializes DAC0OUT and DAC1OUT for speaker and IR light output, respectively
set(AO, 'SampleRate', samprateout);
set(AO, 'TriggerType', 'Manual');

