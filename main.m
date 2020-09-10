clear
close all

addpath utils;
addpath 'qcut_utils';

parent_path = 'simupor_dataset/';
load([parent_path 'datasets.mat']);
total_columns = 1;

for k = 1:total_columns
    dataset_idx = datasets(k);
    dataset_name = ['Column_' num2str(dataset_idx) ];
    dataset_path = [ parent_path dataset_name '/' ];
    disp([dataset_name '... started']);
    
    for scan=['C']
        %disp(scan);
        for chunk={'top','bottom'}
            % Parse paths
            stack_path = [dataset_path scan '/' chunk{1} '.mat'];
            path_out = [dataset_path scan '/' chunk{1} '_out.mat'];
            
            % Load data
            data = load(stack_path); data = data.(chunk{1});
            
            % Normalize data
            data = double(data)/255;
            
            % Apply QCUT
            SalMap = applyQCUTv3(data);
            
            output_mean=mean(SalMap,4);
            output = double(output_mean>=0.75);
            
            % Save output
            saveQCUT(SalMap,path_out);
        end
    end
    disp([dataset_name '... DONE']);
end
