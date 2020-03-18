%% Calculating the performance metric 
disp('Start');
clc;
clear all;
close all;

load('/Users/palashshastri/Documents/BMED/Normalized/all_features_dataset1.mat');
load('/Users/palashshastri/Documents/BMED/Normalized/label.mat');

% idx = randperm(215); % Write this value to dataset 1 so it doesn't change
% save('/Users/palashshastri/Documents/BMED/Normalized/idx.mat','idx');
load('/Users/palashshastri/Documents/BMED/Normalized/idx.mat','idx');
labels = Y(idx); % random labels are present

rand_features = all_features_dataset1(idx,:); %randomized feature vector
rand_features(isnan(rand_features)) = 0;
[features_out,weights] = MI(rand_features,labels,12);

for iter=1:17
    length = 100*iter
    
    for val=1:length
        selected_features(:,val) = rand_features(:,features_out(val));
    end
    
    features_train = selected_features(1:129,:);
    features_test = selected_features(130:215,:);
    
    classhypo = KNN(features_train, features_test, labels(1:129), 5, 1);
    
    classhypo_all(iter,:) = classhypo';
    
    [ua,ac] = uac(classhypo,labels(130:215));
    ua_all(iter) = ua;
    ac_all(iter) = ac;
end