%%
%   getCodeStamp(callingFilePath)
%       
%       To find the callingFilePath run: 
%            stampString = getCodeStamp(mfilename('fullpath'));
%
%       Returns a string with the name and short hash of the git
%       repository housing the calling function. It appends a * if there 
%       are uncommitted changes.
%
%%
function stampString = getCodeStamp(callingFilePath)  
    
    repDir = char(regexp(callingFilePath,'(?<=GitHub\\)\w*','match'));
    repPathStem = char(regexp(callingFilePath,'.*(?=GitHub)','match'));
    repPath = [repPathStem,'GitHub\',repDir];
    cd(repPath)

    % Get the current hash
    [status, shortHash] = system('git rev-parse --short HEAD');
    shortHash = regexprep(shortHash,'\n','');
    
    % Find out if the repository is current
    [status, gitStatus] = system('git status');
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

