function [ normalized_image ] = stain_recombination(stained_mapped1, stained_mapped2, stained_mapped3 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[height width channel] = size(stained_mapped1);

% Standard values from literature
He = [0.550 0.758 0.351]';
Eo = [0.398 0.634 0.600]';
Bg = [0.754 0.077 0.652]';

% Create Deconvolution matrix
M = [He/norm(He) Eo/norm(Eo) Bg/norm(Bg)];
D = inv(M);

HEB = zeros(3, 1);
sampleRGB_OD = zeros(height, width, channel);
for i=1:height
    for j=1:width
        
      	HEB(1)=stained_mapped1(i,j);
       	HEB(2)=stained_mapped2(i,j);
       	HEB(3)=stained_mapped3(i,j);
        
        rgbinverse=inv(D)*HEB;
        sampleRGB_OD(i,j,1) = rgbinverse(1);
        sampleRGB_OD(i,j,2) = rgbinverse(2);
        sampleRGB_OD(i,j,3) = rgbinverse(3);
    end
end

sample_RGB=uint8((256.*exp(-sampleRGB_OD))-1);



normalized_image=sample_RGB;
end

