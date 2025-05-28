% 文件：visualize_results.m
function visualize_results(img1, img2, cls1, cls2, change_map)
    figure('Position', [100 100 1200 600])
    
    subplot(2,3,1); imshow(img1(:,:,1:3)); title('时相1 RGB')
    subplot(2,3,2); imshow(img2(:,:,1:3)); title('时相2 RGB')
    
    % 将 categorical 转为数值类型再显示
    cls1_num = double(cls1);
    cls2_num = double(cls2);
    
    subplot(2,3,4); imagesc(cls1_num); axis image; title('时相1分类')
    subplot(2,3,5); imagesc(cls2_num); axis image; title('时相2分类')
    
    subplot(2,3,6); imshow(change_map); title('变化区域')
    colormap jet
end


function calculate_change_stats(change_map)
    total_pixels = numel(change_map);
    changed_pixels = sum(change_map(:));
    resolution = 0.3; % 需根据数据修改
    changed_area = changed_pixels * (resolution^2);
    fprintf('变化像素占比：%.2f%%\n', 100*changed_pixels/total_pixels)
    fprintf('变化面积：%.2f 平方米\n', changed_area)
end
