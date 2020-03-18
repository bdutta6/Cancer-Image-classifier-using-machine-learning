clear;
close all;
clc;

% Dataset parameters
dn = 1;

% Dataset path
data_dir = {
    '/Users/Mathieu/Documents/Georgia Tech/Spring 2016/ECE 6780 - Medical Image Processing/Project/Dataset1/';
    '/Users/Mathieu/Documents/Georgia Tech/Spring 2016/ECE 6780 - Medical Image Processing/Project/Dataset2/KIRC_Tumor/';
    '/Users/Mathieu/Documents/Georgia Tech/Spring 2016/ECE 6780 - Medical Image Processing/Project/Dataset3/PAAD_Tumor/';
    };
% Batch size
batch_sz = {
    1;    % Or 100 but this will lead to only 3 observations
    16;
    16;
    };
% Output path
output_dir = {
    '/Users/Mathieu/GitHub/BMED-ECE-6780/Module2/Features/Dataset1_features';
    '/Users/Mathieu/GitHub/BMED-ECE-6780/Module2/Features/Dataset2_features';
    '/Users/Mathieu/GitHub/BMED-ECE-6780/Module2/Features/Dataset3_features';
    };
% Image type
img_fname = '*.png';

% Load all filenames
fileList = dir(fullfile(data_dir{dn}, img_fname));
fileList = {fileList.name}';
% Sort by filename
fileList = natsort(fileList);

% Parameters
nbPatients = numel(fileList)/batch_sz{dn};
image_pool = cell(1, batch_sz{dn});
all_features = zeros(nbPatients, 5*4*22);   % Size based on texture extraction functions

fn = 1;
currentPatient = 1; % A batch is a patient (e.g : 16 tiles for one patient in Dataset 2)
while fn < numel(fileList);
    
    % Load tiles in a sample
    for i = fn : fn + batch_sz{dn} - 1
        image_pool{i - fn + 1} = imread([data_dir{dn} '/' fileList{i}]);
    end
    
    % Compute features for the sample
    featuresGLCM = textureGLCM(image_pool);
    %featuresGLRL = textureGLRL(image_pool);
    
    % Save features
    %all_features(currentPatient, :) = [featuresGLCM(:); featuresGLRL(:)]';
    all_features(currentPatient, :) = featuresGLCM(:);
    
    % Go to next sample
    fn = fn + batch_sz{dn};
    currentPatient = currentPatient + 1;
end

featuresReduction(dn, all_features, 3);