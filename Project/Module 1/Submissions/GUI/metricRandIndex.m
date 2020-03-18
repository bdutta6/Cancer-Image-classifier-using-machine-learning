function [ randIndex ] = metricRandIndex( imageLabels1, imageLabels2 )
% Rand Index to compute similarity between groundtruth and segmentation
% Index from 0 to 1 : higher is better !

% Based on
% Measures of Similarity,
% Ranjith Unnikrishnan and Martial Hebert

[imWidth,imHeight]=size(imageLabels1); %Must be the same as imageLabels2

% Lbels start at 1
if min(min(imageLabels1)) < 1
    imageLabels1 = imageLabels1 - min(min(imageLabels1)) + 1;
end
if min(min(imageLabels2)) < 1
    imageLabels2 = imageLabels2 - min(min(imageLabels2)) + 1;
end

%Count how many segments we have (maximum)
segmentCount1=max(max(imageLabels1));
segmentCount2=max(max(imageLabels2));
n=zeros(segmentCount1,segmentCount2);

for i=1:imWidth
    for j=1:imHeight
        u=imageLabels1(i,j);
        v=imageLabels2(i,j);
        n(u,v)=n(u,v)+1;
    end;
end;

% Following eq(3) from "Measures of Similarity" by Ranjith Unnikrishnan and Martial Hebert
N = sum(sum(n));
n_u=sum(n,2);
n_v=sum(n,1);

randIndex = 1 - ( sum(n_u .* n_u)/2 + sum(n_v .* n_v)/2 - sum(sum(n.*n)) ) / (N*(N-1)/2);



end

