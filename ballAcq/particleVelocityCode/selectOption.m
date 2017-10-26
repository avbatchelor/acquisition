function microphone = selectOption(listStr)

s = listdlg('PromptString','Select a microphone:','SelectionMode','single','ListString',listStr);
microphone = listStr{s};