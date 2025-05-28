function change_map = post_classification_compare(classified1, classified2)
    change_map = double(classified1 ~= classified2);
    se = strel('square', 3);
    change_map = imopen(change_map, se);
end
