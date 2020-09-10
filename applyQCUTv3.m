function output=applyQCUTv3(image_now)

image_now = imadjustn(image_now);

agg = [];
aucs = [];
for suppix_num=[2000,4000,6000,8000]
    suppix_num
    [GVMean, suppixel, boundaries,PixNum, LabelLine,width, height,recon]=SolveSlic(image_now,suppix_num,[]);
    [neighbourhood,LF,max_label]=FindNeighbours(suppixel);
    
    ALL_DIST=DistFind(GVMean,max_label);
    ALL_DIST=ALL_DIST/max(ALL_DIST(:));
    
    H=AffinityAssign(neighbourhood,LF,ALL_DIST,max_label,[],[]);
    
    potentials = zeros(size(GVMean));
    potentials(boundaries) = 1;
    
    H_new=UpdateDiagonal(GVMean,[],H,1:max_label,potentials*1000);
    [SalMap,binarized]=QCUT(H_new,1,PixNum, suppixel,image_now);
    
    agg = cat(4,agg,binarized);
end
gg = image_now>graythresh(image_now);
output = agg;
output_mean=mean(agg,4);

end