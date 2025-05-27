# 多时相遥感影像土地利用变化检测（Land Use Change Detection Using Multi-temporal Remote Sensing Imagery）

## 项目简介

本项目基于中国地质大学（武汉）地球信息科学与技术专业，利用多时相遥感影像，结合深度学习方法，实现土地利用/覆盖分类及变化检测。项目采用浅层卷积神经网络（CNN）对遥感影像像素级别进行分类，并通过后分类变化检测方法识别不同时间点的土地利用变化区域。

本项目代码基于 MATLAB 平台开发，流程涵盖数据读取、预处理、深度学习分类、变化检测及面积统计，具有较强的理论研究价值和实际应用意义。该项目可为土地资源管理、环境保护、城市规划和灾害评估等领域提供技术支持。

## 功能特点

- 读取和预处理多时相遥感影像数据
- 基于浅层卷积神经网络的像素级土地利用分类
- 多时相土地利用变化检测
- 变化面积统计与结果可视化
- 代码结构清晰，便于扩展和复现

## 数据集

本项目使用的数据集示例为 UCMerced Land Use 数据集中的农业类遥感影像，数据格式为 GeoTIFF，路径示例：

D:/UCMerced_LandUse/Images/agricultural/agricultural00.tif
D:/UCMerced_LandUse/Images/agricultural/agricultural02.tif


请根据实际情况修改代码中的数据路径。

## 依赖环境

- MATLAB R2019b 及以上版本（推荐）
- Deep Learning Toolbox

## 使用说明

1. 准备遥感影像数据，放置于指定路径。
2. 运行 `generate_train_data.m` 生成训练数据。
3. 运行 `main.m` 执行分类和变化检测流程。
4. 查看终端输出的变化面积统计及图形窗口中的变化检测结果。

## 目录结构

├── main.m % 主程序
├── generate_train_data.m % 生成训练数据脚本
├── load_image.m % 图像读取函数
├── preprocess_image.m % 图像预处理函数
├── classify_image_cnn.m % CNN分类函数
├── change_detection.m % 变化检测函数
├── compute_area.m % 面积统计函数
├── train_data.mat % 训练数据（需运行 generate_train_data.m 生成）
├── README.md % 项目说明文档


## 贡献指南

欢迎对本项目进行 Fork、Issue 反馈和 Pull Request，期待与更多地理信息科学领域的研究者交流合作。

## 联系方式

项目开发者：南杨
邮箱：13036115819@163.com
