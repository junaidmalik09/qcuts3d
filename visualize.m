clear
close all

addpath utils;
addpath 'qcut_utils';

parent_path = 'simupor_dataset/';
load([parent_path 'datasets.mat']);

column_idx = 1;
scan = 'C';
chunk='bottom'; % either top or bottom

dataset_idx = datasets(column_idx);
dataset_name = ['Column_' num2str(dataset_idx) ];
dataset_path = [ parent_path dataset_name '/' ];
disp([dataset_name '... started with ' chunk ' chunk' ]);

% Parse paths
stack_path = [dataset_path scan '/' chunk '.mat'];
gt_path = [dataset_path 'gt_' chunk '.mat'];
path_out = [dataset_path scan '/' chunk '_out.mat'];

% Load data
data = load(stack_path); data = data.(chunk);
gt = load(gt_path); gt = gt.(['gt_' chunk]);
output = load(path_out);
output_mean=mean(output.SalMap,4);
output = double(output_mean>=0.75);

% Normalize data
data = double(data)/255;

implay([data output])
disp([dataset_name '... DONE']);

