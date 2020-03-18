function [ I_mapped ] = NormalizeColorMap( I, tunique_color, sunique_color )
%SETCOLORMAP Summary of this function goes here
%   Detailed explanation goes here

I_mapped={1,length(I)};
for imageCell = 1:length(I)
    temp_I = I{imageCell};
    [height, width, channel] = size(temp_I);
    
    s1Source=temp_I(:,:,1); %Retrieves the three color channels for target
    s2Source=temp_I(:,:,2);
    s3Source=temp_I(:,:,3);

    s1Source_rank=(double(s1Source)*sunique_color)/255;%Retrieves the rank for the three color channels for target based on total no. of available color
    s2Source_rank=(double(s2Source)*sunique_color)/255;
    s3Source_rank=(double(s3Source)*sunique_color)/255;

    
    
    s1Mapped = zeros(height,width);
    s2Mapped = zeros(height,width);
    s3Mapped = zeros(height,width);
    
    s1Mapped_rank=(s1Source_rank*tunique_color)/sunique_color;
    s2Mapped_rank=(s2Source_rank*tunique_color)/sunique_color;
    s3Mapped_rank=(s3Source_rank*tunique_color)/sunique_color;

    s1Mapped = (s1Mapped_rank*255)/sunique_color;
    s2Mapped = (s2Mapped_rank*255)/sunique_color;
    s3Mapped = (s3Mapped_rank*255)/sunique_color;
    
    normalized(:,:,1) = s1Mapped;
    normalized(:,:,2)=s2Mapped;
    normalized(:,:,3)=s3Mapped;
    I_mapped{imageCell}=normalized;

end

end

