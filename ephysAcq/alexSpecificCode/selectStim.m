function [carrierRange,voltage] = selectStim

stimOK = 'n';
while strcmp(stimOK,'n')
    prompt = {'Frequency range:','Volumes:'};
    dlg_title = 'Stim Details';
    num_lines = 1;
    defaultans = struct2cell(getpref('StimDetails'))';
    out = inputdlg(prompt,dlg_title,num_lines,defaultans);

    carrierRange = str2num(out{1});
    voltage = str2num(out{2});

    setpref('StimDetails',{'freqRange','volumes'},out)
    
    numStim = length(carrierRange)*length(voltage); 
    questionString = sprintf('Num stim = %d, is that ok?',numStim);
    stimOK = input(questionString,'s');
end

%addpref('StimDetails',{'freqRange','freqInt','volumes'},{[],[],[]})