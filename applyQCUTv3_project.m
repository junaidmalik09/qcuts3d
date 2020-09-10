function output=applyQCUTv3_project(image_now,gt)

image_now = imadjustn(image_now);

agg = [];
for suppix_num=[4000]
    [GVMean, suppixel, boundaries,PixNum, LabelLine,width, height,recon]=SolveSlic(image_now,suppix_num,[]);
    %boundaries(GVMean(boundaries)>(graythresh(image_now)/2)) = [];
    [neighbourhood,LF,max_label]=FindNeighbours(suppixel);
    ALL_DIST=DistFind(GVMean,max_label);
    ALL_DIST=ALL_DIST/max(ALL_DIST(:));
    H=AffinityAssign(neighbourhood,LF,ALL_DIST,max_label,[],[]);
    potentials = zeros(size(GVMean));
    potentials(boundaries) = 1;
    H_new=UpdateDiagonal(GVMean,[],H,1:max_label,potentials*1000);
    [output]=QCUT_project(H_new,1,PixNum, suppixel,image_now, gt);
    %agg = cat(4,agg,binarized);
end

end