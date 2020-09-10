clear
close all


parent_path = 'D:/';
load('D:/datasets_processed_latest/datasets.mat');

metrics = load('metrics.mat'); metrics = metrics.metrics;
Xs = [];
Ys = [];
AUCs = [];
IOUs = [];

for k = 1:length(datasets)
    dataset_idx = datasets(k);
    dataset_name = ['Column_' num2str(dataset_idx) ];
    dataset_path = [ parent_path 'datasets_processed_latest/' dataset_name '/' ];
    disp([dataset_name '']);
    
    for scan=['C']
        
        
        for chunk={'top'}
            
            % 1. Jaccard
            j = metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).iou;
            
            % 2. AUC
            X = metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).X;
            Y = metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).Y;
            T = metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).T;
            AUC = metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).AUC;
            
            % 3. ME
            me = metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}).me;
            
            disp([j AUC me])
            Xs = [Xs X];
            Ys = [Ys Y];
            AUCs = [AUCs AUC];
            IOUs = [IOUs j];
            
        end
    end
    
end
