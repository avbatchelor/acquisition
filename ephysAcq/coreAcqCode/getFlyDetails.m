function FlyData = getFlyDetails(exptInfo,basename,varargin)

%% Get eclosion date
FlyData.eclosionDate = getEclosionDate;

%% Ask user for input
prompt = {'Line:','Are both a2s glued to head?','Freeness of left antenna:',...
    'Freeness of right antenna: ','Prep type: ','Notes on dissection: ',...
    'Is the fly a virgin?','Target hemisphere (Fly''s ...):','Notes on eclosion date','Male or female?','Leg state'};
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
FlyData.notesOnEclosionDate = cellstr(out(9));
FlyData.sex = cellstr(out(10));
FlyData.legState = cellstr(out(11));

setpref('FlyDetails',{'line','a2','freenessLeft','freenessRight','prepType','notesOnDissection','virgin','hemisphere','eclosion','gender','legState'},...
    out)



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
