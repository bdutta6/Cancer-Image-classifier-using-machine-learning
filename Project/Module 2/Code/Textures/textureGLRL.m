function [ features ] = textureGLRL( image_pool )
%TEXTURE Summary of this function goes here
%   Detailed explanation goes here
%   Compute texture features for a bunch of images
%   which belong to the same batch.

% TODO Switch case to manually select which feature extract, all otherwise

    % Parameters
    nbFeatures = 11;
    features = zeros(1, nbFeatures);        % Final output
    
    GLRL = cell(1,4);
    for i = 1:4
        GLRL{i} = zeros(8,512);
    end

    for i = 1 : numel(image_pool)

        % Get image
        I = image_pool{i};

        % If necessary, convert I to a sgrayscale image
        if size(I,3) ~= 1
            I = rgb2gray(I);
        end;

        % Reduce to 16-level
        I = I/16;

        % Evaluate the GLRL in 4 directions
        glrl = grayrlmatrix(I);

        % Sum tiles GLRL to sample GLRL
        for j = 1:4
            GLRL{j} = GLRL{j} + glrl{j};
        end

    end

    % Compute GLRL properties for one sample
    propertiesGLRL = grayrlprops(GLRL);

    % TODO Maybe no need to mean for all directions
    propertiesGLRL = mean(propertiesGLRL);

    % Add GLRL features to output
    features(:) = propertiesGLRL(:);
end

