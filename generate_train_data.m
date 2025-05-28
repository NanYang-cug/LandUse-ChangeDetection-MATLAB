function generate_train_data()
    clc;

    % 参数设置
    image_path = 'D:/UCMerced_LandUse/Images/agricultural/agricultural00.tif';
    label_path = 'D:/UCMerced_LandUse/Labels/agricultural/agricultural00_labels.tif';
    save_path = 'train_data.mat';
    samples_per_class = 200;
    patch_size = 5;
    half_size = floor(patch_size / 2);

    % 读取图像和标签
    if ~isfile(image_path) || ~isfile(label_path)
        error('图像或标签文件未找到！');
    end

    image = im2double(imread(image_path));
    label_map = imread(label_path);

    % 预处理图像（可选）
    image = preprocess_image(image);

    [H, W, B] = size(image);
    unique_labels = unique(label_map(:));
    num_classes = numel(unique_labels);

    % 初始化训练数据
    train_X = [];
    train_Y = [];

    % 每类采样 patch
    for c = 1:num_classes
        label_value = unique_labels(c);
        [rows, cols] = find(label_map == label_value);
        total_pixels = numel(rows);
        n = min(samples_per_class, total_pixels);
        idx = randperm(total_pixels, n);

        for i = 1:n
            r = rows(idx(i));
            c0 = cols(idx(i));

            if r - half_size < 1 || r + half_size > H || ...
               c0 - half_size < 1 || c0 + half_size > W
                continue;
            end

            patch = image(r-half_size:r+half_size, c0-half_size:c0+half_size, :);
            train_X = cat(4, train_X, patch);
            train_Y(end+1) = label_value;
        end
    end

    train_Y = categorical(train_Y);
    save(save_path, 'train_X', 'train_Y');
    fprintf('训练数据生成完成，共 %d 个样本，%d 个类别\n', numel(train_Y), num_classes);
end
