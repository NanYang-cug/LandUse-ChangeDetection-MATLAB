function generate_fake_labels()
    image_path = 'D:/UCMerced_LandUse/Images/agricultural/agricultural00.tif';
    label_path = 'D:/UCMerced_LandUse/Labels/agricultural/agricultural00_labels.tif';

    if ~isfolder(fileparts(label_path))
        mkdir(fileparts(label_path));
    end

    image = imread(image_path);
    [H,W,~] = size(image);

    % 简单划分为4类区域作为标签
    label_map = zeros(H,W);
    label_map(1:floor(H/2), 1:floor(W/2)) = 1;
    label_map(1:floor(H/2), floor(W/2)+1:end) = 2;
    label_map(floor(H/2)+1:end, 1:floor(W/2)) = 3;
    label_map(floor(H/2)+1:end, floor(W/2)+1:end) = 4;

    imwrite(uint8(label_map), label_path);
    fprintf('假标签已生成，路径：%s\n', label_path);
end
