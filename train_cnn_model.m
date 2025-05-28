function model = train_cnn_model(train_X, train_Y)
    input_size = size(train_X);  % e.g., [5 5 3 N]
    B = input_size(3);
    input_layer = imageInputLayer([5 5 B], 'Name', 'input');

    layers = [
        input_layer
        convolution2dLayer(3, 16, 'Padding', 'same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2, 'Stride', 2)

        convolution2dLayer(3, 32, 'Padding', 'same')
        batchNormalizationLayer
        reluLayer

        dropoutLayer(0.3)

        fullyConnectedLayer(64)
        reluLayer
        fullyConnectedLayer(numel(categories(train_Y)))
        softmaxLayer
        classificationLayer
    ];

    options = trainingOptions('adam', ...
        'MaxEpochs', 30, ...
        'MiniBatchSize', 64, ...
        'Verbose', true, ...
        'Plots', 'training-progress');

    model = trainNetwork(train_X, train_Y, layers, options);
end
