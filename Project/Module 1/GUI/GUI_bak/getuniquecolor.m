
function [ uniquecolor ] = getuniquecolor( I )
%GETCOLORMAP Summary of this function goes here
%   Detailed explanation goes here

%Colormap, one row for one channel
%There can't be more than 255 unique values
    sunique_cell={};
    for imageCell = 1:length(I)
    temp_I = I{imageCell}; %get each image from pool
    [height, width, channel] = size(temp_I);
    ssorted = zeros(height*width,3);
    for i = 1:height
    for j = 1:width
        ssorted((width*(i-1))+j,:)=reshape(temp_I(i,j,:),1,3);% sort all the rgb values in an array
    end
    end
    sunique=unique(ssorted,'rows');%find unique rgb values
   
    sunique_cell{imageCell,1}=sunique;% store unique rgb values for each image in a cell 
    end
    sunique_mat=cell2mat(sunique_cell); %convert the cell to matrix
    sunique_total=unique(sunique_mat,'rows');%find total unique colors over all images
    [uniquecolor, n] =size(sunique_total); %return total number of unique colors
   
end

