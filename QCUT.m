function [eigvec_now_2D,binarized]=QCUT(H,smooth,PixNum, suppixel,image_now)

rng(27);
nn = 1;%round(max(suppixel(:))*1);

[eigvec,eigval]=eigs(H,nn,'SM');

%[sorted,idx] = sort(diag(eigval));
%eigvec = eigvec(:,idx);

%%%% CODE FOR RECONSTRUCTING GT USING TOP 5% OF THE SPECTRUM %%
% gt = gt_orig==2;
% stats_gt = regionprops3(suppixel,gt,'MeanIntensity');
% gt_sp = [stats_gt.MeanIntensity];
% c = dot(eigvec,repmat(gt_sp,[1 size(eigvec,2)]));
% superposed_gt = zeros(size(eigvec(:,1)));
% for k=1:nn
%     superposed_gt = superposed_gt + c(k).*eigvec(:,k);
% end
% reconstructed_gt = sup2pixel( PixNum, suppixel(:)-1, (superposed_gt) );
% reconstructed_gt = reshape( reconstructed_gt,size(suppixel));
% immse(double(reconstructed_gt),double(gt))
% implay(reconstructed_gt)
% keyboard
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




superposed = zeros(size(eigvec(:,1)));
for k=1:nn
    superposed = superposed + ((1/eigval(k,k))*eigvec(:,k));
end
superposed=superposed.^2;
superposed=mat2gray(superposed);

eigvec_now_2D = sup2pixel( PixNum, suppixel(:)-1, (superposed) );
eigvec_now_2D = reshape( eigvec_now_2D,size(suppixel));

[clustered,c] = kmeans(superposed,2);
clustered = sortClusters(clustered,c);
binarized = sup2pixel( PixNum, suppixel(:)-1, (clustered) );
binarized = reshape( binarized,size(suppixel));


    function output=sortClusters(clusters,c)
        output = zeros(size(clusters));
        [~,idx] = sort(c,'descend');
        output(clusters==idx(1)) = 1;
        %for k=1:length(c)
        %    output(clusters==idx(k)) = length(c)-k+1;
        %end
        output = double(output);
    