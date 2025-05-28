function processed = preprocess_image(img)
    processed = zeros(size(img));
    for c = 1:size(img,3)
        band = img(:,:,c);
        processed(:,:,c) = (band - min(band(:))) / (max(band(:)) - min(band(:)));
    end
    if size(img,3) >= 3
        for ch = 1:3
            processed(:,:,ch) = histeq(processed(:,:,ch));
        end
    end
end
