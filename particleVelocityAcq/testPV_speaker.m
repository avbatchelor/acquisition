function testPV_speaker(numrepeats)

% put all experiment info in exp_info (for easily passing into acquisition code)
exp_info.stimType = 'testFmAndCS'; % found in testSpeakerAndPiezo.m
exp_info.protocol = 'takeSweep';

% run experiment
for z = 1:numrepeats
    % configure AI and AO
    [exp_info.AI exp_info.AO] = configAIAO_measureSpeakerPV();
    
    % run data acquisition
    for j=[1 2]
        if j==1
            exp_info.stimName = 'AM stimulus w/ fc = 200 Hz';
            testfm = [1 2 4 8 16];
            exp_info.stim_dur = 2;           % stimulus duration
            exp_info.fc = 200;               % carrier frequency (in Hz)
            exp_info.particle_vel = 3*10^-2; % approximate particle velocity in m/s
            exp_info.intensity = 2;       % voltage required for this intensity/fc combination
            for k=testfm
                exp_info.fm = k;
                runPV_speaker(exp_info);
            end
        elseif j==2
            exp_info.stimName = 'Courtship Song';
            exp_info.fm = 0;
            exp_info.stim_dur = 0;
            exp_info.fc = 0;
            exp_info.particle_vel = 0;
            exp_info.intensity = 3; %1;     % scales down courtship song voltage output so that
                                            % sine song is ~0.4 V (corresponds
                                            % to ~3-4um antennal displacement,
                                            % like 90 Hz AM stimulus above),
                                            % and pulse song portion has a max
                                            % amplitude of ~0.75 V (corresponds
                                            % to ~8-10 um antennal displacement)
            
            runPV_speaker(exp_info);
        end
    end
end
