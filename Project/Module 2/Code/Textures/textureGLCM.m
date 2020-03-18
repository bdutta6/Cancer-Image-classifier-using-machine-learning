function [ features ] = textureGLCM( image_pool )
%TEXTURE Summary of this function goes here
%   Detailed explanation goes here
%   Compute texture features for a bunch of images
%   which belong to the same batch.

% TODO Switch case to manually select which feature extract, all otherwise

    % Parameters
    nbFeatures = 4*5*22;
    features = zeros(1, nbFeatures);    % Final output
    GLCM = zeros(8,8,4*5);              % 5 displacements and 4 orientations

    for d = 1:5
        offset360 = [0 d; -d d; -d 0; -d -d];   % GLCM direction

        for i = 1 : numel(image_pool)

            % Get image
            I = image_pool{i};

            % If necessary, convert I to a sgrayscale image
            if size(I,3) ~= 1
                I = rgb2gray(I);
            end;

            % Reduce to 64-level
            I = I/4;

            % Evaluate the GLCM in all directions
            glcm = graycomatrix(I, 'offset', offset360);

            % Sum tiles GLCM to sample GLCM
            pos = 4*(d-1);
            GLCM(:,:,pos+1) = GLCM(:,:,pos+1) + glcm(:,:,1);
            GLCM(:,:,pos+2) = GLCM(:,:,pos+2) + glcm(:,:,2);
            GLCM(:,:,pos+3) = GLCM(:,:,pos+3) + glcm(:,:,3);
            GLCM(:,:,pos+4) = GLCM(:,:,pos+4) + glcm(:,:,4);
        end

    end
    
    % Compute GLCM properties for one sample (several tiles)
    results = glcm_features(GLCM,0);
    fields = fieldnames(results);
    for i = 1:length(fields)
        pos = 20*(i-1);
        features(pos+1:pos+20) = results.(fields{i});
    end
    
    % Extract features in an array format
    
    
end

