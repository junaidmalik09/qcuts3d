% Calculate projections on ground truth

clear
close all

parent_path = 'D:/malik/datasets_processed_latest/';
load([parent_path 'datasets.mat']);

for k = 1
    dataset_idx = datasets(k);
    dataset_name = ['Column_' num2str(dataset_idx) ];
    dataset_path = [ parent_path dataset_name '/' ];
    disp([dataset_name '... started']);
    
    for scan=['B']
        %disp(scan);
        for chunk={'top','bottom'}
            % Parse paths
            stack_path = [dataset_path scan '/' chunk{1} '.mat'];
            gt_path = [dataset_path 'gt_' chunk{1} '.mat'];
            path_out = [parent_path 'datasets_output/' dataset_name '/' scan '/' chunk{1} '_project_out.mat'];
            mkdir([parent_path 'datasets_output/' dataset_name '/' scan '/'])
            
            % Load data
            data = load(stack_path); data = data.(chunk{1});
            gt = load(gt_path); gt = gt.(['gt_' chunk{1}]);
            
            % Normalize data
            data = double(data)/255;
            
            % Apply QCUT
            tic; output = applyQCUTv3_project(data,gt); toc;
            
            % Plot results
            ll = length(output.MSEs{1});
            fraction = 0.25;
            xx = (1:ll)/ll;
            xx = xx(1:(ll*fraction));
            
            close all;
            hold on
            phase1 = output.MSEs{1}(1:length(xx));
            phase2 = output.MSEs{2}(1:length(xx));
            phase3 = output.MSEs{3}(1:length(xx));
            phase4 = output.MSEs{4}(1:length(xx));
            
            
            subplot 221; plot(xx,phase1); grid on; grid minor; xlim([0 fraction]);
            subplot 222; plot(xx,phase2); grid on; grid minor; xlim([0 fraction]);
            subplot 223; plot(xx,phase3); grid on; grid minor; xlim([0 fraction]);
            subplot 224; plot(xx,phase4); grid on; grid minor; xlim([0 fraction]);
            
            
        end
    end
    disp([dataset_name '... DONE']);
end
