clc;
close all;

colorspace = {'rgb', 'lab', 'hsv'};

% database number (1,2,3)
dn = 1;
% database path, please change it accordingly
source_dir = {
    '/Users/Mathieu/GitHub/BMED-ECE-6780/GUI/Images/Dataset1/Normalized/';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset2\Reference\';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Data\Dataset3\PAAD_Tumor\';
    };

classifier_dir = {
    '/Users/Mathieu/GitHub/BMED-ECE-6780/GUI/Images/Dataset1/Classifiers/';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset2\Reference\';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset3\Reference\';
    };

image_address=strcat(source_dir{dn},'Necrosis_2.png');%add image name here
source_image=imread(image_address);

class_weights=load(strcat(classifier_dir{dn},'LDA_classifiers.mat'));
segmented_image = ldaclassifier(source_image,class_weights);
segmented_image(segmented_image==1)=0;
segmented_image(segmented_image==2)=128;
segmented_image(segmented_image==3)=255;
figure()
colormap(gray);
imagesc(segmented_image);
subplot(1,2,1)
imagesc(source_image);
subplot(1,2,2)
imagesc(segmented_image);