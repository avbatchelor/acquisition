% Make sure to adjust gain of camera before starting 

%% Test frequency tuning 
runExpt('40F04',1,20)

%% Analyse frequency tuning 
plotAllExpts('40F04',expNum,flyNum,cellNum,1,1,cellExpNumToPlot)

%% Test responses to courtship song 
runExpt('40F04',1,21)

%% Test multimodal integration 
runExpt('40F04',1,30)

%% Test temporal integration 

