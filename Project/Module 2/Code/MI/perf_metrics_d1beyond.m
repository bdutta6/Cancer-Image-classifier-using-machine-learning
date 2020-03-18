%% Calculating the performance metric 

disp('Start');
clear all;
close all;
clc;

load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/dataset3_allfeatures.mat');
load('/Users/palashshastri/Documents/BMED/BMED Project/Dataset3/dataset3gradelabel.mat');

% idx = randperm(215); % Write this value to dataset 1 so it doesn't change
% save('/Users/palashshastri/Documents/BMED/Normalized/idx.mat','idx');
% load('/Users/palashshastri/Documents/BMED/Normalized/idx.mat');
% labels = Y(idx); % random labels are present

[features_out,weights] = MI(features_all,double(d3_label),12);
labels = d3_label;

% labels(find(labels==1)) = -1;
% labels(find(labels==2)) = -1;
% labels(find(labels==3)) = -1;
% labels(find(labels==1)) = -1;
for iter=1:17
    length = 100*iter;
    for val=1:length
        selected_features(:,val) = features_all(:,features_out(val));
    end
    size(selected_features);
    
    features_train = selected_features(1:36,:);
    features_test = selected_features(37:59,:);
    
    classhypo = KNN(features_train, features_test, labels(1:36), 5, 1);
    
    classhypo_all(iter,:) = classhypo';
    
    [ua,ac] = uac(classhypo,labels(37:59));
    ua_all(iter) = ua;
    ac_all(iter) = ac;
end