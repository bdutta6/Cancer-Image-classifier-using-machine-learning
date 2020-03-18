function [I_smth] = levelSetSmooth_single(I_orig, I_msk, alpha, iter)
%% default alpha = 0.2, iter = 100

%     I_orig = imread([data_dir{dn} '\Reference\' fileList{fn}]);
%     I_msk = imread(['D:\GoogleDrive\Project\Module1\Supervised_images\Dataset1\Supervised\' fileList{fn}]);
%     I_msk = imread([data_dir{dn} '\Label\' fileList{fn}(1:end-4) '_GT.png']);
%
% nuclei
msk(:,:,1) = uint8(I_msk == 0);
% background
msk(:,:,2) = uint8(I_msk == 255);

seg = chenvese(I_orig,msk,iter,alpha,'multiphase');

%
I_smth = zeros(size(seg));
I_smth(seg(:,:) == 1) = 255;
I_smth(seg(:,:) == 2) = 128;
I_smth(seg(:,:) == 3) = 0;
I_smth(seg(:,:) == 4) = 0;
%imwrite(mat2gray(img), [data_dir{dn} '\Unsupervised\' save_fname]);
% imwrite(mat2gray(I_res), [data_dir{dn} '\Supervised\' fileList{fn}(1:end-4) '_Seg.png']);

close all