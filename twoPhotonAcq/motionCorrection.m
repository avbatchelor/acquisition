function [movCorrected,refFrame] = motionCorrection(mov,metaFileName,frameTimes,varargin)

%% Create refFrame filename 
load(metaFileName)
roiFolder = char(regexp(metaFileName,'.*(?=\\block)','match'));
[~, fileName] = fileparts(metaFileName); 
fileStem = char(regexp(fileName,'.*(?=block)','match'));
refFrameFileName = [roiFolder,'\',fileStem,'refFrame.mat'];

%% Create or load refFrame
numFrames = size(mov,3);
if exist(refFrameFileName,'file') == 2
    load(refFrameFileName) 
else 
    refFrameNum = round(numFrames/2);
    refFrame = mov(:,:,refFrameNum,1);
    save(refFrameFileName,'refFrame');
end

%% Do motion correction 
refFFT = fft2(refFrame);
numMovs = size(mov,4); 
movCorrected = NaN(size(mov)); 
for movNum = 1:numMovs
    for frame=1:numFrames
        [~, Greg] = dftregistration(refFFT,fft2(mov(:,:,frame,movNum)),1);
        movCorrected(:,:,frame,movNum) = real(ifft2(Greg));
    end
end

% %% Check
% mov3 = mov - repmat(refFrame,[1,1,numFrames]);
% cmax = max(mov3(:));
% cmin = min(mov3(:)); 
% 
% frameInds = round(frameTimes.*Stim.sampleRate); 
% figure()
% for j = 1:numMovs
%     for i = 1:numFrames
%         h(1) = subplot(2,3,1);
%         imagesc(mov(:,:,i,j))
%         axis image
%         title('Uncorrected')
%         h(2) = subplot(2,3,2);
%         imagesc(movCorrected(:,:,i,j))
%         axis image
%         title('Corrected')
%         subplot(2,3,3)
%         if i == 1
%             stimBlock = 1:frameInds(i); 
%         else 
%             stimBlock = frameInds(i-1:i);
%         end
%         plot(Stim.timeVec(stimBlock),Stim.stimulus(stimBlock))
%         hold on 
%         h(3) = subplot(2,3,4);
%         image3 = mov(:,:,i,j) - refFrame;
%         imagesc(image3);
%         axis image
%         title('Difference - uncorrected')
%         caxis([cmin cmax])
%         h(4) = subplot(2,3,5);
%         image3 = movCorrected(:,:,i,j) - refFrame;
%         imagesc(image3);
%         caxis([cmin cmax])
%         axis image
%         colorbar
%         title('Difference - corrected')
%         disp(unique(image3))
%         input('')
%         linkaxes(h(:),'x')
%     end
% end

