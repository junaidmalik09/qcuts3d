function [nu] = calcNU(threshed,stack_now)
%CALCNU Summary of this function goes here
%   Detailed explanation goes here
threshed = threshed(:)>0;
stack_now = double(stack_now(:));

P = nnz(threshed==1);
T = numel(threshed);

sigma_p = var(stack_now(threshed==1));
sigma_t = var(stack_now);

nu = (P*sigma_p) / (T*sigma_t);

end

