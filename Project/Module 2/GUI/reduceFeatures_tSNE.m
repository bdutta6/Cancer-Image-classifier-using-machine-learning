function reduced_features = reduceFeatures_tSNE(selected_features, noDims)
%REDUCEFE Summary of this function goes here
%   Detailed explanation goes here

reduced_features = tsne(selected_features, [], noDims, 30, 30);

end

