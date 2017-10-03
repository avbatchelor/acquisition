function getFlyDetailsBall(exptInfo)

%% Get eclosion date
FlyData.eclosionDate = getDate('Eclosion');
FlyData.antennaGluingDate = getDate('Antenna gluing');

%% Ask user for input
prompt = {'Line:','Freeness of left antenna:',...
    'Freeness of right antenna: ','Notes on dissection: ',...
    'Aim','Is the fly a virgin?','Notes on eclosion date','Male or female?','Temperature'};
dlg_title = 'Fly Details';
num_lines = 1;
defaultans = struct2cell(getpref('FlyDetails'))';
out = inputdlg(prompt,dlg_title,num_lines,defaultans);

FlyData.line = cellstr(out(1));
FlyData.freenessLeft = cellstr(out(2));
FlyData.freenessRight = cellstr(out(3));
FlyData.a2Left = cellstr(out(4));
FlyData.a2Right = cellstr(out(5));
FlyData.notesOnDissection = cellstr(out(6));
FlyData.aim = cellstr(out(7));
FlyData.virgin = cellstr(out(8));
FlyData.notesOnEclosionDate = cellstr(out(9));
FlyData.sex = cellstr(out(10));
FlyData.temperature = cellstr(out(11));
FlyData.humidity = cellstr(out(12));

setpref('FlyDetails',{'line','freenessLeft','freenessRight','a2Left','a2Right','notesOnDissection','aim','virgin','eclosion','gender','temp','humidity'},...
    out)

%% Get filename
prefixCode  = exptInfo.prefixCode;
expNum      = exptInfo.expNum;
flyNum      = exptInfo.flyNum;

% Make numbers strings
eNum = num2str(expNum,'%03d');
fNum = num2str(flyNum,'%03d');

settings = ballSettings; 
dataDirectory = settings.dataDirectory;
path = [dataDirectory,prefixCode,'\expNum',eNum,...
        '\flyNum',fNum];

if ~isdir(path)
    mkdir(path)
end
filenameRoot = [prefixCode,'_expNum',eNum,'_flyNum',fNum,'_'];
filename = [path,'\',filenameRoot,'flyData'];

%% Save
save(filename,'FlyData')

