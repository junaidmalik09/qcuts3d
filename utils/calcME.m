function [ME] = calcME(mask,gt)
%CALCME Calculate misclassification error
%   Detailed explanation goes here
mask = mask(:)>0;
gt = gt(:)>0;
ME = 1-((nnz(mask==1 & gt==1) + nnz(mask==0 & gt==0)) / numel(gt));

end

