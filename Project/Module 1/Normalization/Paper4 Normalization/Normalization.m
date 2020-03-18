clc;clear;

reference1 = imread('Reference1.png');
reference2 = imread('Reference2.png');
reference3 = imread('Reference3.png');
source = imread('Source7.png');

reference = cell(3,1);
reference{1} = reference1;
reference{2} = reference2;
reference{3} = reference3;

colorMap = getColorMap(reference);

source_mapped = setColorMap(source,colorMap);
reference1_mapped = setColorMap(reference1,colorMap);
%reference2_mapped = setColorMap(reference2,colorMap);

figure();
subplot(1,3,1),imshow(reference1),title('Reference1');
%subplot(3,3,2),imshow(reference2),title('Reference2');
%subplot(3,3,3),imshow(reference3),title('Reference3');
subplot(1,3,2),imshow(source),title('Source');
subplot(1,3,3),imshow(uint8(source_mapped)),title('SourceMapped');
%subplot(3,3,5),imshow(reference1),title('Reference1');
%subplot(3,3,8),imshow(uint8(reference1_mapped)),title('Reference1Mapped');
%subplot(3,3,6),imshow(reference2),title('Reference2');
%subplot(3,3,9),imshow(uint8(reference2_mapped)),title('Reference2Mapped');

 figure();
 subplot(3,3,1),histogram(reference1),title('Reference1');
% subplot(3,3,2),histogram(reference2),title('Reference2');
% subplot(3,3,3),histogram(reference3),title('Reference3');
 subplot(3,3,4),histogram(source),title('Source');
 subplot(3,3,7),histogram(uint8(source_mapped)),title('SourceMapped');
% subplot(3,3,5),histogram(reference1),title('Reference1');
% subplot(3,3,8),histogram(uint8(reference1_mapped)),title('Reference1Mapped');
% subplot(3,3,6),histogram(reference2),title('Reference2');
% subplot(3,3,9),histogram(uint8(reference2_mapped)),title('Reference2Mapped');