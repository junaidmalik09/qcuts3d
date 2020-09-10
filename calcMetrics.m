clear
close all

addpath ../qcut_3d/utils;

parent_path = 'D:/malik/datasets_processed_latest/';
load('D:/malik/datasets_processed_latest/datasets_processed_latest/datasets.mat');


metrics = struct();

for k = 1%:length(datasets)
    dataset_idx = datasets(k);
    dataset_name = ['Column_' num2str(dataset_idx) ];
    dataset_path = [ parent_path 'datasets_processed_latest/' dataset_name '/' ];
    %disp([dataset_name '... started']);
    
    metrics.(['dataset_' num2str(dataset_idx)]) = struct();
    
    for scan=['C']
        
        metrics.(['dataset_' num2str(dataset_idx)]).(scan) = struct();
        
        for chunk={'top','bottom'}
            
            metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}) = struct();
            
            % Parse paths
            stack_path = [dataset_path scan '/' chunk{1} '.mat'];
            gt_path = [dataset_path 'gt_' chunk{1} '.mat'];
            output_path = [dataset_path scan '/' chunk{1} '_out.mat'];
            
            % Load data
            data = load(stack_path); data = data.(chunk{1});
            gt = load(gt_path); gt = gt.(['gt_' chunk{1}]); gt = gt==2;
            output = load(output_path);
            output_mean=mean(output.SalMap,4);
            output = double(output_mean>=0.75);
            
            % Calc metrics
            % 1. Jaccard
            j = jaccard(double(output),double(gt));
            metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).iou = j;
            
            % 2. AUC
            [X,Y,T,AUC]=perfcurve(gt(:),output(:),1);
            metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).X = X;
            metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).Y = Y;
            metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).T = T;
            metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).AUC = AUC;
            
            % 3. ME
            me = calcME(output,gt);
            metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).me = me;
            
            
        end
    end
    disp([dataset_name '... DONE']);
end
save('metrics.mat','metrics')