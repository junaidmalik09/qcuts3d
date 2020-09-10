clear
close all

% Load datasets,characterization and results
load('D:/malik/datasets_processed_latest/datasets_processed_latest/datasets.mat');
load('D:/malik/datasets_processed_latest/datasets_processed_latest/charac.mat');
load('metrics.mat');

% Init containers
shape_results = cell(3,2);
size_results = cell(3,6);

% For all shapes
shapes = {'sands','qaurtz'};

for shape=1:2
    % For all sizes
    for d=1:6
        % Get list of datasets
        idx = ds.(shapes{shape}).(['d' num2str(d)]);
        
        for dataset=idx
            % Fetch results for this datasets
            for chunk = {'top','bottom'}
                r = metrics.(['dataset_' num2str(dataset)]).C.(chunk{1});
                size_results{1,d} = [size_results{1,d} r.AUC];
                size_results{2,d} = [size_results{2,d} r.iou];
                size_results{3,d} = [size_results{3,d} r.me]; 
                
                shape_results{1,shape} = [shape_results{1,shape} r.AUC];
                shape_results{2,shape} = [shape_results{2,shape} r.iou];
                shape_results{3,shape} = [shape_results{3,shape} r.me];
                         
            end
            
        end
        
    end
end

size_results_mat = cellfun(@(x) mean(x),size_results);
shape_results_mat = cellfun(@(x) mean(x),shape_results);