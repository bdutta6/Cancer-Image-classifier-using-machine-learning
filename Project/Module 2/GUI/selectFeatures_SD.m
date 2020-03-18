function X4 = selectFeatures_SD(all_features_dataset1,Y,ql,threshold)
%SELECTFEATURES_SD Summary of this function goes here
%   Detailed explanation goes here

[features,weights] = SD(all_features_dataset1,Y,ql);
weights = (weights - min(weights))/(max(weights) - min(weights));
rank_index=find(weights>threshold);
if(numel(rank_index)<30)
    disp('Warning : Nb of selected features < 30 initial dimensions');
end
X4=all_features_dataset1(:,features(rank_index));

end

