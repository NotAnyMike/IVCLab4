%% load the material
clear;clc;
load('matfile/pos_train_names.mat');
load('matfile/neg_train_1.mat');
%% train svm
[pos_train,pos_label] = pos_data(pos_train_names);
[neg_train2,neg_label2] = neg_data(neg_train_1);
train_data = [pos_train;neg_train2];
train_label = [pos_label;neg_label2];
svm_model1 = fitcsvm(train_data,train_label,'KernelFunction','gaussian');
%% sliding window
% img_test = imread('Test/example1.png'); i,mg_test = imresize(img_test,[595 385]);
% img_test = imread('Test/example2.png'); img_test = imresize(img_test,[560 760]);
 img_test = imread('Test/example3.png');img_test = imresize(img_test,[480 400]);
% img_test = imread('Test/example4.png'); img_test = imresize(img_test,[728 925]);
% img_test = imread('Test/example5.png'); img_test = imresize(img_test,[668 554]);
% img_test = imread('Test/example6.png'); img_test = imresize(img_test,[545 465]);
window_size = [100, 300];% the size of the sliding window for plot bounding box
locations = findWindows(window_size,img_test,svm_model1);
%% draw the bounding box
merge(locations,img_test);