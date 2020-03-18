GT = imread('/Users/Mathieu/Desktop/GT/Necrosis34_GT.png');
label = imread('/Users/Mathieu/Desktop/Supervised/Stroma_18_Seg.png');
image = imread('/Users/Mathieu/Desktop/Reference/Stroma_18.png');

randIndex = metricInterIndex(GT,label)
interIndex = metricInterIndex(image,label)
intraIndex = metricIntraIndex(image,label)


