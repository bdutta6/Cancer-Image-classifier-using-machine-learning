function intraIndex = metricIntraIndex(image,label)
% Intra-region uniformity index of L?vine and Nazif
% Index from 0 to 1 : higher is better !

% Based on :
% Unsupervised performance evaluation of image segmentation, 
% Special Issue on Performance Evaluation in Image Processing, 
% EURASIP Journal on Applied Signal Processing, pages 1-12, 2006.

% Labels start at 1
if min(min(label)) < 1
    label = label - min(min(label)) + 1;
end

%Count how many segments we have (maximum)
segmentCount=max(max(label));
n=zeros(1,segmentCount);

for k = 1:segmentCount
   [region_k] = find(label==k); % Select region k
   size_k = length(region_k);   % Weight of the region k
   if (size_k == 0)
        n(k)=0; % Contribution of the region to the measure
   else
	  	mean_k = sum(sum(image(region_k))) / size_k; % Contribution of the region to the measure
        Imean = double(image) - ones(size(image)) * mean_k;
        n(k) = sum(sum(Imean(region_k).^2))*4 / (size_k*255*255);
   end;
end;

%Return value
intraIndex = 1 - sum(n); 