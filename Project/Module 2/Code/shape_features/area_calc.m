%% Implementing the HSOM unsupervised method for clustering groups
% function [image,label_fcm] = fcm_implementation(path)

disp('Start');
% clc;
% clear all;
% close all;

path = '/Users/palashshastri/Documents/BMED/BMED Project/Dataset2/KIRC_Tumor/*.png';
Files = dir(path);  % the folder path
% label_matrix_all = zeros(1,512*512);
% center_all = zeros(1,9);

% filename = '/Users/palashshastri/Documents/BMED/BMED Project/Dataset1/Stroma_58.png';
% filename2 = '/Users/palashshastri/Documents/BMED/BMED Project/Results/result.jpg';
% I = imread(filename);
% 
% m = size(I,1);
% n = size(I,2);
% 
% figure, imshow(I);
count = 1;
count_main = 1;
for i1=81:1:1600
    
    filename = strcat('/Users/palashshastri/Documents/BMED/BMED Project/Dataset2/KIRC_Tumor/',Files(i1).name);
    I = imread(filename);
    original_image = I;
    
    m = size(I,1);
    n = size(I,2);

    I_gray = rgb2gray(I);
    I_gray = reshape(I_gray,m*n,1);
    
    I = reshape(I,m*n,3);
    [center,U,obj_fn] = fcm(double(I),3);

    for i=1:1:m*n
        index = find(U(:,i) == max(U(:,i)));

        fcm_image(i,1) = center(index,1);
        fcm_image(i,2) = center(index,2);
        fcm_image(i,3) = center(index,3);
    end

%% Discrepancy map
new_image(:,:,1) = reshape(fcm_image(:,1),m,n);
new_image(:,:,2) = reshape(fcm_image(:,2),m,n);
new_image(:,:,3) = reshape(fcm_image(:,3),m,n);
new_image = uint8(new_image);
image = new_image;
% imwrite(new_image,filename2,'jpg');
center = uint8(center);
ans1 = unique(new_image(:,:,1));
label_matrix = zeros(m,n);
if(length(ans1)>2)
    for i=1:1:m
        for j=1:1:n
            if(new_image(i,j,1) == ans1(1,1))
                label_matrix(i,j) = 1;
            end

            if(new_image(i,j,1) == ans1(2,1))
                label_matrix(i,j) = 2;
            end

            if(new_image(i,j,1) == ans1(3,1))
                label_matrix(i,j) = 3;
            end
        end
    end
    
    
    label_fcm = label_matrix;

    %% Calculating region properties for each of the sixteen images

    bw = (label_fcm == 1); % Change this to 2 and 3
    bw_image = bwareaopen(bw,40);
    region = regionprops(bw_image,'all');

    %% Storing all the required properties in different variables, 11 features in total

    area = cat(1,region.Area);
    majaxis = cat(1,region.MajorAxisLength);
    minaxis = cat(1,region.MinorAxisLength);
    eccentricity = cat(1,region.Eccentricity);
    orient = cat(1,region.Orientation);
    convarea = cat(1,region.ConvexArea);
    solidity = cat(1,region.Solidity);
    filledarea = cat(1,region.FilledArea);
    eunumber = cat(1,region.EulerNumber);
    extent = cat(1,region.Extent);
    perimeter = cat(1,region.Perimeter);

    %% Extracting individual 8 features from each of the above

    b = mod(i1,16);
    if(b==0)
        b = 16;
    end
    area_all(1,b) = min(area);
    area_all(2,b) = max(area);
    area_all(3,b) = mean(area);
    area_all(4,b) = median(area);
    area_all(5,b) = std(area);
    area_all(6,b) = iqr(area);
    area_all(7,b) = skewness(area);
    area_all(8,b) = kurtosis(area);

    majaxis_all(1,b) = min(majaxis);
    majaxis_all(2,b) = max(majaxis);
    majaxis_all(3,b) = mean(majaxis);
    majaxis_all(4,b) = median(majaxis);
    majaxis_all(5,b) = std(majaxis);
    majaxis_all(6,b) = iqr(majaxis);
    majaxis_all(7,b) = skewness(majaxis);
    majaxis_all(8,b) = kurtosis(majaxis);

    minaxis_all(1,b) = min(minaxis);
    minaxis_all(2,b) = max(minaxis);
    minaxis_all(3,b) = mean(minaxis);
    minaxis_all(4,b) = median(minaxis);
    minaxis_all(5,b) = std(minaxis);
    minaxis_all(6,b) = iqr(minaxis);
    minaxis_all(7,b) = skewness(minaxis);
    minaxis_all(8,b) = kurtosis(minaxis);

    eccentricity_all(1,b) = min(eccentricity);
    eccentricity_all(2,b) = max(eccentricity);
    eccentricity_all(3,b) = mean(eccentricity);
    eccentricity_all(4,b) = median(eccentricity);
    eccentricity_all(5,b) = std(eccentricity);
    eccentricity_all(6,b) = iqr(eccentricity);
    eccentricity_all(7,b) = skewness(eccentricity);
    eccentricity_all(8,b) = kurtosis(eccentricity);

    orient_all(1,b) = min(orient);
    orient_all(2,b) = max(orient);
    orient_all(3,b) = mean(orient);
    orient_all(4,b) = median(orient);
    orient_all(5,b) = std(orient);
    orient_all(6,b) = iqr(orient);
    orient_all(7,b) = skewness(orient);
    orient_all(8,b) = kurtosis(orient);

    convarea_all(1,b) = min(convarea);
    convarea_all(2,b) = max(convarea);
    convarea_all(3,b) = mean(convarea);
    convarea_all(4,b) = median(convarea);
    convarea_all(5,b) = std(convarea);
    convarea_all(6,b) = iqr(convarea);
    convarea_all(7,b) = skewness(convarea);
    convarea_all(8,b) = kurtosis(convarea);

    solidity_all(1,b) = min(solidity);
    solidity_all(2,b) = max(solidity);
    solidity_all(3,b) = mean(solidity);
    solidity_all(4,b) = median(solidity);
    solidity_all(5,b) = std(solidity);
    solidity_all(6,b) = iqr(solidity);
    solidity_all(7,b) = skewness(solidity);
    solidity_all(8,b) = kurtosis(solidity);

    filledarea_all(1,b) = min(filledarea);
    filledarea_all(2,b) = max(filledarea);
    filledarea_all(3,b) = mean(filledarea);
    filledarea_all(4,b) = median(filledarea);
    filledarea_all(5,b) = std(filledarea);
    filledarea_all(6,b) = iqr(filledarea);
    filledarea_all(7,b) = skewness(filledarea);
    filledarea_all(8,b) = kurtosis(filledarea);

    eunumber_all(1,b) = min(eunumber);
    eunumber_all(2,b) = max(eunumber);
    eunumber_all(3,b) = mean(eunumber);
    eunumber_all(4,b) = median(eunumber);
    eunumber_all(5,b) = std(eunumber);
    eunumber_all(6,b) = iqr(eunumber);
    eunumber_all(7,b) = skewness(eunumber);
    eunumber_all(8,b) = kurtosis(eunumber);

    extent_all(1,b) = min(extent);
    extent_all(2,b) = max(extent);
    extent_all(3,b) = mean(extent);
    extent_all(4,b) = median(extent);
    extent_all(5,b) = std(extent);
    extent_all(6,b) = iqr(extent);
    extent_all(7,b) = skewness(extent);
    extent_all(8,b) = kurtosis(extent);

    perimeter_all(1,b) = min(perimeter);
    perimeter_all(2,b) = max(perimeter);
    perimeter_all(3,b) = mean(perimeter);
    perimeter_all(4,b) = median(perimeter);
    perimeter_all(5,b) = std(perimeter);
    perimeter_all(6,b) = iqr(perimeter);
    perimeter_all(7,b) = skewness(perimeter);
    perimeter_all(8,b) = kurtosis(perimeter);

    feature_vector = zeros(8,11);
    if(b==16)
        area_mean = mean(area_all,2);
        majaxis_mean = mean(majaxis_all,2);
        minaxis_mean = mean(minaxis_all,2);
        eccentricity_mean = mean(eccentricity_all,2);
        orient_mean = mean(orient_all,2);
        convarea_mean = mean(convarea_all,2);
        solidity_mean = mean(solidity_all,2);
        filledarea_mean = mean(filledarea_all,2);
        eunumber_mean = mean(eunumber_all,2);
        extent_mean = mean(extent_all,2);
        perimeter_mean = mean(perimeter_all,2);

        feature_vector(:,1) = area_mean;
        feature_vector(:,2) = majaxis_mean;
        feature_vector(:,3) = minaxis_mean;
        feature_vector(:,4) = eccentricity_mean;
        feature_vector(:,5) = orient_mean;
        feature_vector(:,6) = convarea_mean;
        feature_vector(:,7) = solidity_mean;
        feature_vector(:,8) = filledarea_mean;
        feature_vector(:,9) = eunumber_mean;
        feature_vector(:,10) = extent_mean;
        feature_vector(:,11) = perimeter_mean;

        m1 = size(feature_vector,1);
        n1 = size(feature_vector,2);

        feature_vector = reshape(feature_vector,1,m1*n1);
        final_feature_vector(count_main,:) = feature_vector(1,:);
        count_main = count_main + 1;
    end
end

%% Discretizing the above distributions
% [N,edges] = histcounts(area,16);
% area_dist(:,i1) = edges;
% area_number(:,i1) = N;
% 
% [N,edges] = histcounts(majaxis,16);
% majaxis_dist(:,i1) = edges;
% majaxis_number(:,i1) = N;
% 
% [N,edges] = histcounts(minaxis,16);
% minaxis_dist(:,i1) = edges;
% minaxis_number(:,i1) = N;
% 
% [N,edges] = histcounts(eccentricity,16);
% ecc_dist(:,i1) = edges;
% ecc_number(:,i1) = N;
% 
% [N,edges] = histcounts(orient,16);
% orient_dist(:,i1) = edges;
% orient_number(:,i1) = N;
% 
% [N,edges] = histcounts(convarea,16);
% convarea_dist(:,i1) = edges;
% convarea_number(:,i1) = N;
% 
% [N,edges] = histcounts(solidity,16);
% solidity_dist(:,i1) = edges;
% solidity_number(:,i1) = N;
% 
% [N,edges] = histcounts(filledarea,16);
% filledarea_dist(:,i1) = edges;
% filledarea_number(:,i1) = N;
% 
% [N,edges] = histcounts(eunumber,16);
% eunumber_dist(:,i1) = edges;
% eunumber_number(:,i1) = N;
% 
% [N,edges] = histcounts(extent,16);
% extent_dist(:,i1) = edges;
% extent_number(:,i1) = N;
% 
% [N,edges] = histcounts(perimeter,16);
% perimeter_dist(:,i1) = edges;
% perimeter_number(:,i1) = N;

end
save('/Users/palashshastri/Documents/BMED/BMED Project/shape_features_80onwards.mat','final_feature_vector');
% end

% end
% save(filename3,'label_matrix_all');
% save(filename4,'center_all');
%% Implementing region mergin algorithm


% Finding the number of regions