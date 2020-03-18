function displayMetrics(text, selected_features, labels, noDataset)
%DISPLAYMETRICS Summary of this function goes here
%   Detailed explanation goes here

% This is for dataset1. Dataset2 the length is 1728 and for Dataset3 it is
% 100

features_train = selected_features(1:129,:)
features_test = selected_features(130:215,:)
labels
classhypo = KNN(features_train, features_test, labels(1:129), 5, 1);

[ua,ac] = uac(classhypo,labels(130:215)); % These are the two metrics you need to display. ac is accuracy and ua is unweighted average recall.
ua
ac
output = sprintf('Features metrics : \nUnweighted average recall: %.2f\nAccuracy: %.2f',ua,ac);
set(text, 'String', output);

end

