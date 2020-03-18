% clc;
% clear all;
% source_image_address='\\prism.nas.gatech.edu\bdutta6\vlab\desktop\MIP\Normalization\Source9.png';
% target_image_address='\\prism.nas.gatech.edu\bdutta6\vlab\desktop\MIP\Normalization\Source7.png';
function[norm_image]=cdvl_stain(source_image_address,target_image_address)
[s1Source, s2Source, s3Source]=stain_retrieval(source_image_address);%Retrieves the three stain channels for source
[s1Target, s2Target, s3Target]=stain_retrieval(target_image_address);%Retrieves the three stain channels for target

[height, width] = size(s1Source);
% s1Source=reshape(normr(reshape((s1Source),1,height*width)),height, width);
% s1Source=(s1Source-min(min(s1Source)))/max(max(s1Source));
% s2Source=(s2Source-min(min(s2Source)))/max(max(s2Source));
% s3Source=(s3Source-min(min(s3Source)))/max(max(s3Source));

means1Source = mean2(s1Source);
means2Source = mean2(s2Source);
means3Source = mean2(s3Source);
stds1Source = std2(s1Source);
stds2Source = std2(s2Source);
stds3Source = std2(s3Source);

% s1Target=(s1Target-min(min(s1Target)))/max(max(s1Target));
% s2Target=(s2Target-min(min(s2Target)))/max(max(s2Target));
% s3Target=(s3Target-min(min(s3Target)))/max(max(s3Target));

means1Target = mean2(s1Target);
means2Target = mean2(s2Target);
means3Target = mean2(s3Target);
stds1Target = std2(s1Target);
stds2Target = std2(s2Target);
stds3Target = std2(s3Target);

s1Mapped = zeros(height,width);
s2Mapped = zeros(height,width);
s3Mapped = zeros(height,width);

for i = 1:512
    for j = 1:512
  
%         if((s1Target(i,j)<(max(max(s1Target)))-1))
        s1Mapped(i,j) = ((s1Source(i,j)-means1Source)/stds1Source)*stds1Target+means1Target;
%         end
%         if((s2Target(i,j)<(max(max(s2Target)))-1))
        s2Mapped(i,j) = ((s2Source(i,j)-means2Source)/stds2Source)*stds2Target+means2Target;
%         end
%         if((s3Target(i,j)<(max(max(s3Target)))-1))
        s3Mapped(i,j) = ((s3Source(i,j)-means3Source)/stds3Source)*stds3Target+means3Target;
%         end
    end
end
% s3Mapped=s3Source;
normalized = stain_recombination(s1Mapped, s2Mapped, s3Mapped );
% figure(1)
% imagesc(normalized);
norm_image=normalized;
end