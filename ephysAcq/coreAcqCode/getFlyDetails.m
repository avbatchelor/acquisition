function FlyData = getFlyDetails(exptInfo,basename,varargin)

%% Ask user for input
prompt = {'Line:','Are both a2s glued to head?','Freeness of left antenna:',...
    'Freeness of right antenna: ','Prep type: ','Notes on dissection: ',...
    'Is the fly a virgin?','Target hemisphere (Fly''s ...):'};
dlg_title = 'Fly Details';
num_lines = 1;
defaultans = struct2cell(getpref('FlyDetails'))';
out = inputdlg(prompt,dlg_title,num_lines,defaultans);

FlyData.line = cellstr(out(1));
FlyData.a2 = cellstr(out(2));
FlyData.freenessLeft = cellstr(out(3));
FlyData.freenessRight = cellstr(out(4));
FlyData.prepType = cellstr(out(5));
FlyData.notesOnDissection = cellstr(out(6));
FlyData.virgin = cellstr(out(7));
FlyData.hemisphere = cellstr(out(8));

setpref('FlyDetails',{'line','a2','freenessLeft','freenessRight','prepType','notesOnDissection','virgin','hemisphere'},...
    out)

% Get eclosion date
h = uicontrol('Style', 'pushbutton', 'Position', [20 150 100 70]);
uicalendar('DestinationUI', {h, 'String'});
waitfor(h,'String'); 
FlyData.eclosionDate = get(h,'String');
close all

%% Get filename
prefixCode  = exptInfo.prefixCode;
expNum      = exptInfo.expNum;
flyNum      = exptInfo.flyNum;

% Make numbers strings
eNum = num2str(expNum,'%03d');
fNum = num2str(flyNum,'%03d');

ephysSettings; 
path = [dataDirectory,prefixCode,'\expNum',eNum,...
        '\flyNum',fNum];

if ~isdir(path)
    mkdir(path)
end
if exist('basename','var')
    filename = [path,'\',basename,'flyData'];
else 
    filename = [path,'\flyData'];
end

%% Save
save(filename,'FlyData')
