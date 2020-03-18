clear;close;clc;

% Read the RGB image
% filename = 'TCGA-IB-7897_13';
filename = 'D:\Dropbox\PhD\Courses\16Spring\Medical Image Proc\Proj\data\Dataset3\PAAD_Tumor\TCGA-IB-7888_685';

I = imread(strcat(filename,'.png'));
[row, col, s] = size(I);

% Initialize the 3 classes
classes = {'nucleus','cytoplasm','background'};
nbClasses = length(classes);
regions = false([row col nbClasses]);

% User interaction : manually select regions
fig = figure;
for i = 1:nbClasses
    imshow(I);
    set(fig,'name',['Select region for ' classes{i}], 'Position', get(0,'Screensize'));
    roiH = imfreehand();
    regions(:,:,i) = createMask(roiH);
    %regions(:,:,i) = roipoly(I);
end
close(fig);

% Convert RGB to LAB colorspace
%labImage = rgb2lab(I);
cform = makecform('srgb2lab');
labImage = applycform(I,cform);

% Calculate mean of a and b for each region
a = labImage(:,:,2);
b = labImage(:,:,3);

colorMarker = zeros(nbClasses,2);

for i = 1:nbClasses
    colorMarker(i,1) = mean2(a(regions(:,:,i)));
    colorMarker(i,1) = mean2(b(regions(:,:,i)));
end

% Classify each pixel using the nearest neighbor rule
% Calculating euclidian distance between the pixel and the colorMarker

colorLabel = 0:nbClasses-1;
a = double(a);
b = double(b);
distance = repmat(0,[size(a), nbClasses]);

% Compute euclidian distance
for i = 1:nbClasses
    distance(:,:,i) = ((a-colorMarker(i,1).^2 + (b-colorMarker(i,2)).^2)).^0.5;
end

[value, label] = min(distance,[],3);
label = colorLabel(label);

% Create pseudo-color image
pseudoColor = [0 0 255 ; 255 0 255; 255 255 255];
J = zeros(size(I));
k = double(label)+1;

c = zeros(3, 3);
for i = 1:row
    for j = 1:col
        J(i,j,:) = pseudoColor(k(i,j),:);
        c(k(i,j), :) = c(k(i,j), :) + I(i, j, :);
    end
end

fig = figure('name','Original and Segmented image');
subplot(1,2,1),imshow(I),title('Original');
subplot(1,2,2),imshow(J);title('Segmented');
set(fig,'Position', get(0,'Screensize'));

imwrite(J,strcat(filename,'_GT.png'));


% get average color for each phase
