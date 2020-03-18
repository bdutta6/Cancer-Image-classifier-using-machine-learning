%% Calculating the performance metric 
disp('Start');
clc;
clear all;
close all;

% This is for dataset1. Dataset2 the length is 1728 and for Dataset3 it is
% 100

length = 100;

for val=1:length
    selected_features(:,val) = features(:,features_out(val)); %Here features is the original feature matrix. Replace features_out with the output features
    %of MI. Selected features will give you the top 100 features for
    %dataset1 which was best of dataset1
end

features_train = selected_features(1:129,:);
features_test = selected_features(130:215,:);

classhypo = KNN(features_train, features_test, labels(1:129), 5, 1);

[ua,ac] = uac(classhypo,labels(130:215)); % These are the two metrics you need to display. ac is accuracy and ua is unweighted average recall.