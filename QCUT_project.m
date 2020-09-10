function [results]=QCUT_project(H,smooth,PixNum, suppixel,image_now, gt_orig)

rng(27);

[eigvec,eigval]=eigs(H,max(suppixel(:)),'SM');

[~,idx] = sort(diag(eigval));
eigvec = eigvec(:,idx);

%%%% CODE FOR RECONSTRUCTING GT USING TOP 10% OF THE SPECTRUM %%
AUCs = {};
IOUs = {};
MSEs = {};

% Convert gt to superpixel
stats = regionprops(suppixel,gt_orig+1,'MeanIntensity');


for phase=0:3
    
    gt = gt_orig==phase;
    stats_gt = regionprops3(suppixel,gt,'MeanIntensity');
    gt_sp = [stats_gt.MeanIntensity];
    c = dot(eigvec,repmat(gt_sp,[1 size(eigvec,2)]));
    
     MSEs{phase+1} = [];
    
    for nn=1:10:max(suppixel(:))
        %nn = round(max(suppixel(:))*spectrum);
        superposed_gt = zeros(size(eigvec(:,1)));
        for k=1:nn
            superposed_gt = superposed_gt + c(k).*eigvec(:,k);
        end
        superposed_gt=superposed_gt.^2;
        superposed_gt=mat2gray(superposed_gt);
        
        MSEs{phase+1} = [MSEs{phase+1} immse(superposed_gt,gt_sp)];
        
    end
    
end




results.MSEs = MSEs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%