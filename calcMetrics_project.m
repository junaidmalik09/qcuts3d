clear
close all

addpath ../qcut_3d/utils;

parent_path = 'D:/malik/datasets_processed_latest/';
load([parent_path 'datasets.mat']);


MSEs1 = {};
MSEs2 = {};
MSEs3 = {};
MSEs4 = {};


nn = 500;

for k = 1:length(datasets)
    dataset_idx = datasets(k);
    dataset_name = ['Column_' num2str(dataset_idx) ];
    dataset_path = [ parent_path dataset_name '/' ];
    %disp([dataset_name '... started']);
    
    metrics.(['dataset_' num2str(dataset_idx)]) = struct();
    
    for scan=['B']
        
        metrics.(['dataset_' num2str(dataset_idx)]).(scan) = struct();
        
        for chunk={'top','bottom'}
            
            metrics.(['dataset_' num2str(dataset_idx)]).(scan).(chunk{1}) = struct();
            
            % Parse paths
            stack_path = [dataset_path scan '/' chunk{1} '.mat'];
            gt_path = [dataset_path 'gt_' chunk{1} '.mat'];
            output_path = [dataset_path scan '/' chunk{1} '_project_full_out.mat'];
            
            % Load data
            %data = load(stack_path); data = data.(chunk{1});
            %gt = load(gt_path); gt = gt.(['gt_' chunk{1}]); gt = gt==2;
            %output = load(output_path);
            %output_mean=mean(output.SalMap,4);
            %output = double(output_mean>=0.75);
            
            % Calc metrics
            load(output_path)
            MSEs1{k} = output.MSEs{1}(2:nn);
            MSEs2{k} = output.MSEs{2}(2:nn);
            MSEs3{k} = output.MSEs{3}(2:nn);
            MSEs4{k} = output.MSEs{4}(2:nn);
            
        end
    end
    disp([dataset_name '... DONE']);
end

% Plot results

close all;
hold on
xx = (2:nn)/4000;
phase1 = mean(cell2mat(MSEs1'),1);
phase2 = mean(cell2mat(MSEs2'),1);
phase3 = mean(cell2mat(MSEs3'),1);
phase4 = mean(cell2mat(MSEs4'),1);

hold on
%subplot 221; 
loglog(xx,phase1,'LineWidth',1.5);  %xlim([0 0.25]);

%subplot 222; 
loglog(xx,phase2,'LineWidth',1.5);  %xlim([0 0.25]);

%subplot 223; 
loglog(xx,phase3,'LineWidth',1.5);  %xlim([0 0.25]);

%subplot 224; 
loglog(xx,phase4,'LineWidth',1.5);  %xlim([0 0.25]);
%save('metrics_project.mat','metrics')

grid minor;
ylabel('Reconstruction error');
xlabel('Percentage of spectrum used for reconstruction of ground truth');

legend({'Solid','Oil','Water','Gaseous'});