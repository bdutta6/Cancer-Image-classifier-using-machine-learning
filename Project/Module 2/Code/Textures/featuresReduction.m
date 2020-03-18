function [ output_args ] = featuresReduction( noDataset, all_features, nbDims )
%FEATURESREDUCTION Summary of this function goes here
%   Detailed explanation goes here

switch(noDataset)
    case 1
        % No info about patients' grades
        % 3 classes to classify
        c1 = [0 1 0]; % Color necrosis
        c2 = [0 0 1]; % Color stroma
        c3 = [1 0 0]; % Color tumor
        
        % Init colors
        cNecrosis = [];
        cStroma = [];
        cTumor = [];
        for i = 1:15
            cNecrosis = vertcat(cNecrosis,c1);
        end
        for i = 1:9
            cStroma = vertcat(cStroma,c2);
        end
        for i = 1:26
            cTumor = vertcat(cTumor,c3);
        end
        color = vertcat(cNecrosis,cStroma,cTumor);
        
        % Reduce dimensions
        [mapped, mapping] = pca(all_features,nbDims);
        mappedX = tsne(all_features,[],nbDims);
        
        % Plot on reducted dimensions (nbDims = 3)
        scatter3(mapped(:,1),mapped(:,2),mapped(:,3),40,color,'filled');
        scatter3(mappedX(:,1),mappedX(:,2),mappedX(:,3),40,color,'filled');
        
    case 2
        % Load info about patients
        xls_dir = '/Users/Mathieu/Documents/Georgia Tech/Spring 2016/ECE 6780 - Medical Image Processing/Project/Dataset2/';
        xls_file = 'KIRC_Training_Set';
        [~,~,trainingRaw] = xlsread([xls_dir xls_file]);
        xls_file = 'KIRC_Testing_Set';
        [~,~,testingRaw] = xlsread([xls_dir xls_file]);

        % TODO : Auto-Map patient grades to color of each entry in all_features
        %%%%%
        c1 = [0 1 0]; % Color grade 1
        c2 = [0 0 1]; % Color grade 2
        c3 = [1 0 0]; % Color grade 3
        c4 = [0 0 0]; % Color grade 4
        color = [c2;c3;c4;c4;c4;c2;c3;c3;c4;c2;c3;c2;c3;c3;c3;c2;c3;c2;c2;c2;
            c3;c2;c3;c3;c2;c3;c3;c2;c2;c2;c3;c3;c3;c3;c2;c2;c2;c2;c3;c2;c3;c2;
            c1;c2;c2;c2;c2;c2;c4;c3;c2;c3;c2;c2;c2;c2;c4;c4;c2;c3;c3;c4;c2;c2;
            c2;c2;c4;c2;c2;c4;c3;c3;c3;c3;c4;c2;c3;c3;c3;c3;c2;c3;c2;c3;c2;c2;
            c2;c2;c2;c4;c2;c3;c2;c2;c4;c3;c4;c4;c2;c2];

        % Reduce dimensions
        [mapped, mapping] = pca(all_features,nbDims);
        mappedX = tsne(all_features,[],nbDims);

        % Plot on reducted dimensions (nbDims = 3)
        scatter3(mapped(:,1),mapped(:,2),mapped(:,3),40,color,'filled');
        scatter3(mappedX(:,1),mappedX(:,2),mappedX(:,3),40,color,'filled');
end
end

