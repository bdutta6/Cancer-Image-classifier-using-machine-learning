[features,weights] = SD(all_features_dataset1,Y,3);
weights = (weights - min(weights))/(max(weights) - min(weights));
rank_index=find(weights>threshold);
X4=all_features_dataset1(:,features(rank_index));
[mappedX, mapping] = pca(X4, 2);
dim1=mappedX(:,1);
dim2=mappedX(:,2);
figure()
plot(dim1(1:52),dim2(1:52),'r*');
hold on
plot(dim1(53:132),dim2(53:132),'k*');
hold on
plot(dim1(133:215),dim2(133:215),'b*');
legend('necrosis','stroma','tumor')


[mappedX, mapping] = pca(X4, 3);
dim1=mappedX(:,1);
dim2=mappedX(:,2);
dim3=mappedX(:,3);
figure()
scatter3(dim1(1:52),dim2(1:52),dim3(1:52),'r');
hold on
scatter3(dim1(53:132),dim2(53:132),dim3(53:132),'k');
hold on
scatter3(dim1(133:215),dim2(133:215),dim3(133:215),'b');
legend('necrosis','stroma','tumor')


[mappedX, mapping] = pca(all_features_sorted, 3);
dim1=mappedX(:,1);
dim2=mappedX(:,2);
dim3=mappedX(:,3);
grade1=find(gradesLabelDataset2==1);
grade2=find(gradesLabelDataset2==2);
grade3=find(gradesLabelDataset2==3);
grade4=find(gradesLabelDataset2==4);
grade5=find(gradesLabelDataset2==5);
grade1x=dim1(grade1);
grade2x=dim1(grade2);
grade3x=dim1(grade3);
grade4x=dim1(grade4);
grade1y=dim2(grade1);
grade2y=dim2(grade2);
grade3y=dim2(grade3);
grade4y=dim2(grade4);
grade1z=dim3(grade1);
grade2z=dim3(grade2);
grade3z=dim3(grade3);
grade4z=dim3(grade4);
scatter3(grade1x,grade1y,grade1z,'r');
hold on
scatter3(grade2x,grade2y,grade2z,'k');
hold on;
scatter3(grade3x,grade3y,grade3z,'b');
hold on;
scatter3(grade4x,grade4y,grade4z,'g');
legend('grade1','grade2','grade3','grade4');




[mappedX, mapping] = pca(all_features_sorted, 2);
dim1=mappedX(:,1);
dim2=mappedX(:,2);
grade1x=dim1(grade1);
grade2x=dim1(grade2);
grade3x=dim1(grade3);
grade4x=dim1(grade4);
grade1y=dim2(grade1);
grade2y=dim2(grade2);
grade3y=dim2(grade3);
grade4y=dim2(grade4);
plot(grade1x,grade1y,'r');
hold on;
plot(grade2x,grade2y,'k');
hold on;
plot(grade3x,grade3y,'b');
hold on;
plot(grade4x,grade4y,'g');
figure()
plot(grade1x,grade1y,'r*');
hold on;
plot(grade2x,grade2y,'k*');
hold on;
plot(grade3x,grade3y,'b*');
hold on;
plot(grade4x,grade4y,'g*');
legend('grade1','grade2','grade3','grade4');

