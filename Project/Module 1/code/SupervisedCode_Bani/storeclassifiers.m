clc;
close all;

colorspace = {'rgb', 'lab', 'hsv'};

% database number (1,2,3)
dn = 3;
% database path, please change it accordingly
ref_dir = {
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset1\Reference\';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset2\Reference\';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Test\Reference\';
    };
label_dir = {
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset1\Label\';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset2\Label\';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Test\Label\';
    };
% batch_sz = {
%     100;
%     16;
%     16;
%     };
output_dir = {
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset1\Reference\';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Dataset2\Reference\';
    'C:\Users\dgoldman3\Documents\Bani_coursework\MIP\Project\Supervised\Ground_Truth\Test\Reference\';
    };

img_fname = '*.png';

% reference image batch, please change it accordingly
ref_fname = {
    '*.png';
    '*.png';
    '*.png';
    };

% pull out reference image for the entire dataset
fileList = dir(fullfile(ref_dir{dn}, ref_fname{dn}));
fileList = {fileList.name}';
fileList=natsortfiles(fileList);

reference_pool = {1,numel(fileList)};
for i=1:numel(fileList)
    img_tmp = imread([ref_dir{dn} '\' fileList{i}]);
    reference_pool{i} = img_tmp;
end

% pull out label image for the entire dataset
fileList2 = dir(fullfile(label_dir{dn}, ref_fname{dn}));
fileList2 = {fileList2.name}';
fileList2=natsortfiles(fileList2);


label_pool = {1,numel(fileList2)};
for j=1:numel(fileList2)
    img_tmp2 = imread([label_dir{dn} '\' fileList2{j}]);
    label_pool{j} = img_tmp2;
end
classifier_weights = getgroundtruthlabels(reference_pool,label_pool);
cd(output_dir{dn});

save('LDA_classifiers.mat','classifier_weights');
