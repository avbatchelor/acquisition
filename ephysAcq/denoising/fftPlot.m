function fftPlot(pfft,fVals)

% Plot them each on a log scale
figure(2);
plot(fVals, 10*log10(pfft));
xlabel('Frequency (Hz)');
ylabel('PSD(dB)'); 
xlim([0 5000]);
ylim([-100 0]);