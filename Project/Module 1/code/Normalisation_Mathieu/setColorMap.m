function [ I_mapped ] = setColorMap( I, colorMap )
%SETCOLORMAP Summary of this function goes here
%   Detailed explanation goes here

for imageCell = 1:length(I)
    I_mapped{imageCell} = zeros(512,512,3);

    for channel = 1:3
        temp_I1 = zeros(512,512,1);
        temp_I2 = I{imageCell}(:,:,channel);

        [sorted_I, index_I] = sort(temp_I2);
        [rank_I, ia, ic] = unique(sorted_I);

        for i = 1:length(colorMap(:,channel))
            v = sorted_I(ic == i);
            if numel(v) > 0
                temp_I1(temp_I2(:) == v(1)) = colorMap(i,channel);
            end
        end

        I_mapped{imageCell}(:,:,channel) = reshape(temp_I1, 512, 512, 1);
    end
end

end

