function reduced_features = reduceFeatures_PCA(selected_features, noDims)
%REDUCEF Summary of this function goes here
%   Detailed explanation goes here

[mappedX, ~] = pca(selected_features, noDims);

reduced_features = mappedX;

end

