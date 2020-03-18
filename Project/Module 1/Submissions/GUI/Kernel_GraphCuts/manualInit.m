function [colorMarker] = manualInit(I, classes)

[row, col, s] = size(I);

% Initialize the classes
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
% cform = makecform('srgb2lab');
% labImage = applycform(I,cform);

% Calculate mean of a and b for each region
% a = labImage(:,:,2);
% b = labImage(:,:,3);
% img_r = I(:,:,1);
% img_g = I(:,:,2);
% img_b = I(:,:,3);

% colorMarker = zeros(nbClasses,3);
%
% for i = 1:nbClasses
%     colorMarker(i,1) = mean2(img_r(regions(:,:,i)));
%     colorMarker(i,2) = mean2(img_g(regions(:,:,i)));
%     colorMarker(i,3) = mean2(img_b(regions(:,:,i)));
% end

colorMarker = zeros(nbClasses, s);

for cn=1:s
    I_tmp = I(:, :, cn);
    for i = 1:nbClasses
        colorMarker(i, cn) = mean2(I_tmp(regions(:,:,i)));
    end
end