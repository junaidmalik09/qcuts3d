function [GVMean, suppixel,boundaries,PixNum, LabelLine,width, height,recon]=SolveSlic(image_now,suppix_num,m)
suppixel = superpixels3(image_now,suppix_num);
pixelIdxList = label2idx(suppixel);
numlabels = max(suppixel(:));
GVMean = zeros(1,numlabels);
for superpixel = 1:numlabels
    memberPixelIdx = pixelIdxList{superpixel};
    GVMean(superpixel) = mean(image_now(memberPixelIdx));
end
LabelLine = suppixel(:)-1;
PixNum = numel(image_now);
width = size(image_now,1); height = size(image_now,2);
recon = [];
recon = sup2pixel( numel(suppixel), (suppixel(:)-1), GVMean );
recon = reshape(recon,size(suppixel));

%Find superpixels on boundaries
boundaries = [];
for i=1:size(suppixel,3)
   for j=1:size(suppixel,2)
       sp = suppixel(:,j,i);
       rc = recon(:,j,i);
       boundaries = [boundaries; unique(sp(rc==min(rc(:))))];
   end
end

close all
boundaries=unique(boundaries);

