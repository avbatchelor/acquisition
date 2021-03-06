function plotBallData(stim,rawData,trialMeta,exptInfo)

%% Figure settings 
close all
set(0,'DefaultFigureWindowStyle','docked')
subplot = @(m,n,p) subtightplot (m, n, p, [0.01 0.05], [0.1 0.05], [0.1 0.01]);

%% Process data 
% [procData.vel(:,1),procData.disp(:,1),procData.xSaturationWarning] = processDigBallData(rawData(:,5:12),stim,'x',exptInfo);
% [procData.vel(:,2),procData.disp(:,2),procData.ySaturationWarning] = processDigBallData(rawData(:,13:20),stim,'y',exptInfo);
% Switched axes on 04/24/2018
[procData.vel(:,1),procData.disp(:,1),procData.xSaturationWarning] = processDigBallData(rawData(:,13:20),stim,'x',exptInfo);
[procData.vel(:,2),procData.disp(:,2),procData.ySaturationWarning] = processDigBallData(rawData(:,5:12),stim,'y',exptInfo);

%% Calculate trial averages 
sumData = sumBallData2(procData,trialMeta,exptInfo,stim);

%% Plot figures
% Stimulus 
figure(1)
h(1) = subplot(6,2,1) ;
mySimplePlot(stim.timeVec,stim.stimulus)
title('Velocity and displacement vs. time')
set(gca,'XTick',[])
ylabel({'stim';'(V)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
set(gca,'XColor','white')
symAxisY(h(1))

% Lateral speed 
h(2) = subplot(6,2,3);
mySimplePlot(stim.timeVec,procData.vel(:,1))
set(gca,'XTick',[])
ylabel({'Lateral Speed';'(mm/s)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
moveXAxis(stim)
shadestimArea(stim)
symAxisY(h(2))
title(['Mean speed = ',num2str(sumData.meanTrialSpeed(end)),' mm/s'])

% Forward speed 
h(3) = subplot(6,2,5);
mySimplePlot(stim.timeVec,procData.vel(:,2))
set(gca,'XTick',[])
ylabel({'Forward Speed';'(mm/s)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
shadestimArea(stim)
moveXAxis(stim)
symAxisY(h(3))

% Lateral displacement 
h(4) = subplot(6,2,7);
mySimplePlot(stim.timeVec,procData.disp(:,1))
set(gca,'XTick',[])
ylabel({'X Disp';'(mm)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
shadestimArea(stim)
moveXAxis(stim)
symAxisY(h(4))
disp(['Max x disp = ',num2str(max(abs(procData.disp(:,1))))]);

% Forward displacement 
h(5) = subplot(6,2,9);
mySimplePlot(stim.timeVec,procData.disp(:,2))
ylabel({'Y Disp';'(mm)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
line([stim.timeVec(1),stim.timeVec(end)],[0,0],'Color','k')
shadestimArea(stim)
xlabel('Time (s)')
linkaxes(h(:),'x')
symAxisY(h(5))
disp(['Max y disp = ',num2str(max(abs(procData.disp(:,2))))]);


% X vs Y displacement
subplot(6,2,2:2:6)
plot(procData.disp(:,1),procData.disp(:,2))
hold on
plot(procData.disp(1,1),procData.disp(1,2),'go')
text(procData.disp(1,1),procData.disp(1,2),'start','Color','g','FontSize',12);
plot(procData.disp(end,1),procData.disp(end,2),'ro')
text(procData.disp(end,1),procData.disp(end,2),'stop','Color','r','FontSize',12);
plot(0,0,'bo')
text(0,0,'stim start','Color','b','Fontsize',12);
symAxis
ylabel('Y displacement (mm)')
title('X-Y displacement')

% Trial speed bar plot 
subtightplot (6, 2, 11, [0.1 0.05], [0.1 0.01], [0.1 0.01]);
bar(1:length(sumData.meanTrialSpeed),sumData.meanTrialSpeed)
xlim([-20 20])
xlabel('Trial number')
ylabel('Trial average speed (mm/s)')
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
box off;
set(gca,'TickDir','out')
axis tight

% Mean displacement 
subtightplot (6, 2, 8:2:12, [0.1 0.05], [0.1 0.01], [0.1 0.01]);
uniqueStim = unique(sumData.stimNum);
numStim = length(uniqueStim);
if isfield(trialMeta,'totalStimNum')
    colorSet = distinguishable_colors(trialMeta.totalStimNum,'w');
else
    colorSet = distinguishable_colors(numStim,'w');
end
for i = 1:numStim
    stimPlotNum = uniqueStim(i);
    p(i) = plot(sumData.byStim(stimPlotNum).meanXDisp,sumData.byStim(stimPlotNum).meanYDisp,'Color',colorSet(stimPlotNum,:),'DisplayName',sumData.byStim(stimPlotNum).description);
    hold on
end

symAxis
xlabel('X displacement (mm)')
ylabel('Y displacement (mm)')
legend(p(:),'Location','eastoutside')
legend('boxoff')
suptitle({['Angle = ',num2str(stim.speakerAngle)];...
    ['X Sat = ',num2str(procData.xSaturationWarning),' | Y Sat = ',num2str(procData.ySaturationWarning)];...
    ['Total X = ',num2str(sumData.totalXWarnings),' | Total Y = ',num2str(sumData.totalYWarnings)]})

end

function shadestimArea(stim)
gray = [192 192 192]./255;
pipStarts = stim.startPadDur;
pipEnds = stim.startPadDur + stim.stimDur;
Y = ylim(gca);
X = [pipStarts,pipEnds];
line([X(1) X(1)],[Y(1) Y(2)],'Color',gray);
line([X(2) X(2)],[Y(1) Y(2)],'Color',gray);
colormap hsv
alpha(.1)
end

function moveXAxis(stim)
set(gca,'XColor','white')
line([stim.timeVec(1),stim.timeVec(end)],[0,0],'Color','k')
end