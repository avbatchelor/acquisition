function [state] = selectState

prompt = {'State1:','State2:'};
dlg_title = 'Specify states';
num_lines = 1;
defaultans = {'',''};
out = inputdlg(prompt,dlg_title,num_lines,defaultans);

state{1} = out{1};
state{2} = out{2};
