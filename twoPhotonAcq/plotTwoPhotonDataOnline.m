function data = plotTwoPhotonDataOnline(imageFileName,metaFileName)

%% Load image and meta data
%load(metaFileName);

imageFileName = 'C:\Users\Alex\Documents\Data\CalciumImagingData\B1\150604\150604_F1_C1\SpeakerStimulus_Images_150604_F1_C1_34\SpeakerStimulus_Image_044.tif';
[~,mov] = scim_openTif(imageFileName);

numFrames = size(mov,4);
numChans = size(mov,3);

%% Image processing
% Remove the last line where the image doesn't change
mov(64,:,:,:)=[];

%% Load or select ROI
currRoiNum = getpref('scimSavePrefs','roiNum');
lastRoiNum = getpref('scimPlotPrefs','lastRoiNum');
roifig = figure;
colormap(gray);
greenAvg = squeeze(nanmean(mov(:,:,2,:),4));
imagesc(greenAvg);
if 1%lastRoiNum == currRoiNum
    oldRoi = getpref('scimPlotPrefs','roi');
    roi = impoly(gca,oldRoi);
else    
    roiObj = imfreehand(gca,'Closed',1);
    roi = wait(roiObj);
end
mask = createMask(roi);
close(roifig)

%% Calculate fluorescence count in ROI
greenMov = squeeze(mov(:,:,2,:));
repMask = squeeze(repmat(mask,[1,1,1,numFrames]));
greenMov(~repMask) = nan;
figure()
imagesc(greenMov(:,:,1))
fCount = squeeze(nanmean(nanmean(greenMov,2),1));

%% Save roi
%setpref('scimPlotPrefs','roi',roi);
data.roi = roi;

%% Plot
figure()
subplot(2,1,1)
%plot(stim.stimulus)
subplot(2,1,2)
plot(fCount)
ylabel('F (counts)')
xlabel('Time (s)')


end



% function exp_t = makeScimStackTime(i_info,num_frame,params)
% dscr = i_info(1).ImageDescription;
% strstart = regexp(dscr,'state.acq.frameRate=','end');
% strend = regexp(dscr,'state.acq.frameRate=\d*\.\d*','end');
% delta_t = 1/str2double(dscr(strstart+1:strend));
% t = makeInTime(params);
% exp_t = [fliplr([-delta_t:-delta_t:t(1)]), 0:delta_t:t(end)];
% exp_t = exp_t(1:num_frame);


