function displayFeatures(hAxe, noDataset, reduced_features, labels, noDims)
%DISPLAYFEATURES Summary of this function goes here
%   Detailed explanation goes here

switch noDataset
    case 1
        switch noDims
            case 1
            case 2
                dim1=reduced_features(:,1);
                dim2=reduced_features(:,2);
                axes(hAxe), plot(dim1(1:52),dim2(1:52),'r*');
                hold on, plot(dim1(53:132),dim2(53:132),'k*');
                hold on, plot(dim1(133:215),dim2(133:215),'b*');
                rotate3d(hAxe,'off');
            case 3
                dim1=reduced_features(:,1);
                dim2=reduced_features(:,2);
                dim3=reduced_features(:,3);
                idx_label1 = find(labels == 1);
                idx_label2 = find(labels == 2);
                idx_label3 = find(labels == 3);
                axes(hAxe),scatter3(dim1(idx_label1),dim2(idx_label1),dim3(idx_label1),'r*');
                hold on, scatter3(dim1(idx_label2),dim2(idx_label2),dim3(idx_label2),'k*');
                hold on, scatter3(dim1(idx_label3),dim2(idx_label3),dim3(idx_label3),'b*');
                rotate3d(hAxe,'on');
        end
        legend('necrosis','stroma','tumor')
        hold off
        
    case 2
        switch noDims
            case 1
            case 2
                dim1=reduced_features(:,1);
                dim2=reduced_features(:,2);
                grade1=find(labels==1);
                grade2=find(labels==2);
                grade3=find(labels==3);
                grade4=find(labels==4);
                grade1x=dim1(grade1);
                grade2x=dim1(grade2);
                grade3x=dim1(grade3);
                grade4x=dim1(grade4);
                grade1y=dim2(grade1);
                grade2y=dim2(grade2);
                grade3y=dim2(grade3);
                grade4y=dim2(grade4);
                axes(hAxe), plot(grade1x,grade1y,'r*');
                hold on, plot(grade2x,grade2y,'k*');
                hold on, plot(grade3x,grade3y,'b*');
                hold on, plot(grade4x,grade4y,'g*');
                rotate3d(hAxe,'off');
            case 3
                dim1=reduced_features(:,1);
                dim2=reduced_features(:,2);
                dim3=reduced_features(:,3);
                grade1=find(labels==1);
                grade2=find(labels==2);
                grade3=find(labels==3);
                grade4=find(labels==4);
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
                axes(hAxe), scatter3(grade1x,grade1y,grade1z,'r');
                hold on, scatter3(grade2x,grade2y,grade2z,'k');
                hold on, scatter3(grade3x,grade3y,grade3z,'b');
                hold on, scatter3(grade4x,grade4y,grade4z,'g');
                rotate3d(hAxe,'on');
        end
        legend('grade1','grade2','grade3','grade4');
        hold off
    case 3
        switch noDims
            case 1
            case 2
                dim1=reduced_features(:,1);
                dim2=reduced_features(:,2);
                grade1=find(labels==1);
                grade2=find(labels==2);
                grade3=find(labels==3);
                grade4=find(labels==4);
                grade1x=dim1(grade1);
                grade2x=dim1(grade2);
                grade3x=dim1(grade3);
                grade4x=dim1(grade4);
                grade1y=dim2(grade1);
                grade2y=dim2(grade2);
                grade3y=dim2(grade3);
                grade4y=dim2(grade4);
                axes(hAxe), plot(grade1x,grade1y,'r*');
                hold on, plot(grade2x,grade2y,'k*');
                hold on, plot(grade3x,grade3y,'b*');
                hold on, plot(grade4x,grade4y,'g*');
                rotate3d(hAxe,'off');
            case 3
                dim1=reduced_features(:,1);
                dim2=reduced_features(:,2);
                dim3=reduced_features(:,3);
                grade1=find(labels==1);
                grade2=find(labels==2);
                grade3=find(labels==3);
                grade4=find(labels==4);
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
                axes(hAxe), scatter3(grade1x,grade1y,grade1z,'r');
                hold on, scatter3(grade2x,grade2y,grade2z,'k');
                hold on, scatter3(grade3x,grade3y,grade3z,'b');
                hold on, scatter3(grade4x,grade4y,grade4z,'g');
                rotate3d(hAxe,'on');
        end
        legend('grade1','grade2','grade3','grade4');
        hold off
        
end
end

