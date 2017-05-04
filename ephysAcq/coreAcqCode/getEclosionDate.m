function eclosionDate = getEclosionDate

% Get eclosion date
set(0,'DefaultFigureWindowStyle','normal')
h = uicontrol('Style', 'pushbutton', 'Position', [20 150 100 70]);
uicalendar('DestinationUI', {h, 'String'});
waitfor(h,'String'); 
eclosionDate = get(h,'String');
close all