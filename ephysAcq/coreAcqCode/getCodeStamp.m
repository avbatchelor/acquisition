%   getCodeStamp(callingFilePath)
%   JSB
%   AVB 2016
%       
%       To get the stamp string just insert this line into the code that
%       you want the stamp string of. 
%            stampString = getCodeStamp(mfilename('fullpath'));
%
%       Returns a string with the name and short hash of the git
%       repository housing the calling function. It appends a * if there 
%       are uncommitted changes.
%
%%
function stampString = getCodeStamp(callingFilePath)  
    
    % Get the name and path of current git repository
    repDir = char(regexp(callingFilePath,'(?<=GitHub\\)\w*','match'));
    repPathStem = char(regexp(callingFilePath,'.*(?=GitHub)','match'));
    repPath = [repPathStem,'GitHub\',repDir];
    cd(repPath)

    % Get the current hash
    gitPath = 'C:\Users\Alex\AppData\Local\GitHub\PortableGit_624c8416ee51e205b3f892d1d904e06e6f3c57c8\cmd\git.exe';
    [~, shortHash] = system([gitPath,' rev-parse --short HEAD']);
%     [status, shortHash] = system('git rev-parse --short HEAD');
    shortHash = regexprep(shortHash,'\n','');
    
    % Find out if the repository is current
    [~, gitStatus] = system([gitPath,' status']);
%     [status, gitStatus] = system('git status');
    if isempty(regexp(gitStatus,'working directory clean'))
        % Working directory isn't clean, there are un-committed changes
        currentFlag = '*';
        if ~isempty(regexp(gitStatus,'Not a git repository'))
            shortHash = 'NotAGitRepo';
        end
    else
        currentFlag = '';
    end
    stampString = [repDir,'-',shortHash,currentFlag];

