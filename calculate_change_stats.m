% 文件：calculate_change_stats.m
function calculate_change_stats(change_map)
    total_pixels = numel(change_map);
    changed_pixels = sum(change_map(:));

    % 假设分辨率为0.3米/像素（根据实际数据调整）
    resolution = 0.3; 
    changed_area = changed_pixels * (resolution^2);

    fprintf('变化检测结果统计：\n')
    fprintf('变化像素占比：%.2f%%\n', 100 * changed_pixels / total_pixels)
    fprintf('变化区域面积：%.2f 平方米\n', changed_area)
end
