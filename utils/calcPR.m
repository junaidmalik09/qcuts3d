function [recall,precision] = calcPR(output,gt)
%CALCPR Summary of this function goes here
%   Detailed explanation goes here

    output = mat2gray(output)*255;
    gt = gt>0;

    



end

