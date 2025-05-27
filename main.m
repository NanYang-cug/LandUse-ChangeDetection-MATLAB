clear; clc;

% ====== 参数设置 ======
image1_path = '../data/image_2015.tif';
image2_path = '../data/image_2020.tif';
train_data_path = '../train_data/train_data.mat';

% ====== 加载遥感影像 ======
image1 = load_image(image1_path);
image2 = load_image(image2_path);

% ====== 预处理（归一化） ======
image1 = preprocess_image(image1);
image2 = preprocess_image(image2);

% ====== 加载训练样本，执行深度学习分类（浅层CNN） ======
load(train_data_path);  % 包含变量：train_X, train_Y
classified1 = classify_image_cnn(image1, train_X, train_Y);
classified2 = classify_image_cnn(image2, train_X, train_Y);

% ====== 变化检测（后分类法） ======
change_map = change_detection(classified1, classified2);

% ====== 面积统计 ======
compute_area(change_map);

% ====== 可视化结果 ======
figure; imagesc(change_map); axis image; colorbar;
title('Land Use Change Detection Map');


% 文件：load_image.m
function image = load_image(filename)
    if ~isfile(filename)
        error('文件未找到：%s，请检查路径是否正确。', filename);
    end
    [image, ~] = readgeoraster(filename);
    image = double(image);
end


% 文件：classify_image_cnn.m
function classified = classify_image_cnn(image, train_X, train_Y)
    % 假设图像为 H x W x B，按像素级分类构建浅层 CNN 网络
    % 提取所有像素样本
    [H, W, B] = size(image);
    data = reshape(image, [], B);

    % 构建 CNN 输入：将每个像素作为 1x1xB 图像
    X = reshape(data', B, 1, 1, []);
    Y = categorical(train_Y);

    % 构建浅层 CNN 网络
    layers = [
        imageInputLayer([1 1 B], 'Normalization','none')
        fullyConnectedLayer(64)
        reluLayer
        fullyConnectedLayer(numel(unique(train_Y)))
        softmaxLayer
        classificationLayer];

    options = trainingOptions('adam', ...
        'MaxEpochs', 15, ...
        'MiniBatchSize', 256, ...
        'Verbose', false, ...
        'Plots','none');

    % 准备训练数据
    numTrain = size(train_X, 1);
    XTrain = reshape(train_X', B, 1, 1, numTrain);

    % 训练网络
    net = trainNetwork(XTrain, Y, layers, options);

    % 使用训练好的模型进行分类
    predicted = classify(net, X);
    classified = reshape(predicted, H, W);
end
