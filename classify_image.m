function classified = classify_image(image, model)
    patch_size = 5;
    half = floor(patch_size/2);
    [H, W, B] = size(image);
    padded = padarray(image, [half half], 'symmetric');
    classified = zeros(H, W);

    for i = 1:H
        for j = 1:W
            patch = padded(i:i+patch_size-1, j:j+patch_size-1, :);
            pred = classify(model, patch);
            classified(i,j) = double(pred);
        end
    end
end
