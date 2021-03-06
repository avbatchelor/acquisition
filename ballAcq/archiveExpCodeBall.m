function archiveExpCodeBall(exptInfo)
    
    [~, path, fileNamePreamble, ~] = getDataFileNameBall(exptInfo);
    scriptFileName = [path,fileNamePreamble,'stimSetCode.m'];

    % Make a copy of the the source m-file
    if ~isdir(path)
        mkdir(path);
    end

    [ST] = dbstack();
    copyfile(which(ST(2).name),scriptFileName);
    disp(['Archived ',ST(2).file,' to ',scriptFileName]);

end