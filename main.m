function main()
    % 第一步：生成假标签（只需执行一次）
    generate_fake_labels();

    % 第二步：生成训练数据
    generate_train_data();

    % 第三步：加载数据，训练模型
    load('train_data.mat', 'train_X', 'train_Y');
    model = train_cnn_model(train_X, train_Y);
    save('trained_model.mat', 'model');

    % 第四步：读取并预处理时相图像
    image1 = preprocess_image(im2double(imread('D:/UCMerced_LandUse/Images/agricultural/agricultural00.tif')));
    image2 = preprocess_image(im2double(imread('D:/UCMerced_LandUse/Images/agricultural/agricultural02.tif')));

    % 第五步：分类
    classified1 = classify_image(image1, model);
    classified2 = classify_image(image2, model);

    % 第六步：变化检测
    change_map = post_classification_compare(classified1, classified2);

    % 第七步：结果可视化和统计
    visualize_results(image1, image2, classified1, classified2, change_map);
    calculate_change_stats(change_map);
end
