function microphone = selectOption(typeSelected,listStr)

s = listdlg('PromptString',['Select a :',typeSelected],'SelectionMode','single','ListString',listStr);
microphone = listStr{s};