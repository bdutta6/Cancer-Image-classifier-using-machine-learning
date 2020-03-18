function [ stats ] = ClassificationMetrics(predicted_labels,true_labels,target_value,plot_bool)
%CLASSIFICATIONMETRICS Summary of this function goes here
%   Compute classification between predicated and true labels
%   Work for binary label (target_value vs other value)
%   To check multilabel perfomance, compute the mean of each metric
%   by calling several times the function

% TP: true positive, TN: true negative, 
% FP: false positive, FN: false negative

if target_value == 0
    stats1 = ClassificationMetrics(predicted_labels,true_labels,1,0);
    stats2 = ClassificationMetrics(predicted_labels,true_labels,2,0);
    stats3 = ClassificationMetrics(predicted_labels,true_labels,3,0);
    
    % Compute mean value
    accuracy = mean([stats1.accuracy,stats2.accuracy,stats3.accuracy]);
    sensitivity = mean([stats1.sensitivity,stats2.sensitivity,stats3.sensitivity]);
    specificity = mean([stats1.specificity,stats2.specificity,stats3.specificity]);
    precision = mean([stats1.precision,stats2.precision,stats3.precision]);
    recall = mean([stats1.recall,stats2.recall,stats3.recall]);
    f_score = mean([stats1.f_score,stats2.f_score,stats3.f_score]);
    gmean = mean([stats1.gmean,stats2.gmean,stats3.gmean]);
    Xroc = stats1.Xroc;
    Yroc = stats1.Yroc;
    
else
% Check for positive and negative labels
idx = (true_labels()==target_value);
pos = length(true_labels(idx));
neg = length(true_labels(~idx));
N = pos+neg;

% Compute true positive and true negative
TP = sum(true_labels(idx)==predicted_labels(idx));
TN = sum(true_labels(~idx)==predicted_labels(~idx));

% Infer false positive and false negative
FP = neg-TN;
FN = pos-TP;
tp_rate = TP/pos;
tn_rate = TN/neg;

% Compute some metrics
accuracy = (TP+TN)/N;
sensitivity = tp_rate;
specificity = tn_rate;
precision = TP/(TP+FP);
recall = sensitivity;
f_score = 2*((precision*recall)/(precision + recall));
gmean = sqrt(tp_rate*tn_rate);

% Compute ROC
% Using builtin matlab function
[Xroc,Yroc] = perfcurve(true_labels,predicted_labels,target_value);
end

auc = trapz(Yroc,Xroc);

if (plot_bool)
    area(Yroc, Xroc,'FaceColor','g');
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    title(['ROC curve - (AUC = ' num2str(auc) ' )']);
else
    disp('area(Yroc,Xroc) to see the ROC function');
end

%TODO
%Confusion matrix

% Prepare output
field1 = 'accuracy';  value1 = accuracy;
field2 = 'sensitivity';  value2 = sensitivity;
field3 = 'specificity';  value3 = specificity;
field4 = 'precision';  value4 = precision;
field5 = 'recall';  value5 = recall;
field6 = 'f_score';  value6 = f_score;
field7 = 'gmean';  value7 = gmean;
field8 = 'Xroc'; value8 = Xroc;
field9 = 'Yroc'; value9 = Yroc;
stats = struct(field1,value1,field2,value2,field3,value3,...
    field4,value4,field5,value5,field6,value6,field7,value7,...
    field8,value8,field9,value9);



end

