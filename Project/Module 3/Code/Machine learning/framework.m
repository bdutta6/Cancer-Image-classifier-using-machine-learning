%% Using random forests for classification purposes
% Should include the entire framework with the loss function plots
clc;
% clear all;
close all;

%% For dataset3
% load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/dataset3gradelabel.mat');
% load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/selected_100.mat');
% labels = double(d3_label);
% train_end = 35; test_start = train_end + 1; test_end = length(labels);

load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/train_patient_idx.mat');
load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/test_patient_idx.mat');
load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/train_labels.mat');
load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/test_labels.mat');
load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/selected_100.mat');

% labels = d3_label;

%% For dataset2
% load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset2/train_patient_idx.mat');
% load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset2/test_patient_idx.mat');
% load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset2/gradesLabelDataset2.mat');
% load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset2/selected_1728.mat');

M = importdata('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/PAAD_Train_Set.csv');
% labels = double(gradesLabelDataset2);

labels(find(labels==1)) = -1;
labels(find(labels==2)) = -1;
labels(find(labels==3)) = 1;
labels(find(labels==4)) = 1;

ytrain = train_labels;
ytest = test_labels;

xtrain = features_selected(patient_index,:);
xtest = features_selected(test_idx,:);

% Splitting the data into train and test

% xtrain = features_selected(1:train_end,1:100);
% ytrain = labels(1:train_end);
% 
% xtest = features_selected(test_start:test_end,1:100);
% ytest = labels(test_start:test_end);
% Making a tree ensemble or random forest

bag = TreeBagger(200,xtrain,ytrain,'OOBPred','On','Method','classification','NVarToSample','all');
Mdl = fitensemble(xtrain,ytrain,'Subspace',200,'KNN','Method','Classification');

SVMmodel = fitcsvm(xtrain,ytrain,'KernelFunction','linear','KernelScale','auto');
csvm = crossval(SVMmodel);
for i=1:1:7
    model = csvm.Trained{i};
%     model_ensemble = Mdl.Trained{i};
    output_labels = predict(model,xtest);
%     out_labels = predict(model_ensemble,xtest);
    
    acc = mean(ytest == output_labels)
%     acc_ensemble = mean(ytest == out_labels)
end

%% Reporting classification metrics

stats = ClassificationMetrics(output_labels,ytest,1,true);

%% From karpathy's blog

opts.classfierID= [2, 3]; % use both 2D-linear weak learners (2) and conic (3)
m= forestTrain(xtrain, ytrain);
yhat = forestTest(m, xtest);
fprintf('Training accuracy = %.2f\n', mean(yhat==ytest));

% Plotting the out of bag loss

loss = oobError(bag);
figure, plot(loss); grid on;

% Predicting the output labels
[pred_labels,scores] = predict(bag,xtest);
pred_labels = str2double(pred_labels);

% pred_ensemble = predict(Mdl,xtest);

% Finding the accuracy of the model
acc_bagger = mean(ytest==pred_labels)
% acc_ensemble = mean(ytest==pred_ensemble)