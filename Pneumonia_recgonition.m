clear; clc; close all;
%% rescale the brightness

%% determine condition to be severe by white area over threshould
figure(1)
I = imread('middle.png');
subplot(1, 4, 1); imshow(I); title('Original Image');
[L, Centers] = imsegkmeans(I, 3);
B = labeloverlay(I, L);
subplot(1, 4, 2); imshow(B); title('Using K means to segment')
gray = rgb2gray(B);
subplot(1, 4, 3); imshow(gray);
% after_threshold = gray < 60;
% subplot(1, 4, 4); imshow(after_threshold); title('after filter');
% %Split into RGB Channels
% Red = B(:, :, 1);
% Green = B(:, :, 2);
% Blue = B(:, :, 3);
% %Get histValues for each channel
% [yRed, x] = imhist(Red);
% [yGreen, x] = imhist(Green);
% [yBlue, x] = imhist(Blue);
% %Plot them together in one plot
% figure
% plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');

% figure
% BWc1 = imclearborder(im0);
% imshow(BWc1)
%%
