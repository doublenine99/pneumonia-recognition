clear; clc; close all;
%% rescale the brightness

%% determine condition to be severe by white area over threshould
figure(1)
% I = imread('good.png');
I = rgb2gray(imread('middle.png'));
subplot(1, 4, 1); imshow(I); title('Original Image');
% remove the coutour part
mask = zeros(size(I));
mask(25:end - 5, 25:end - 10) = 1;
% imshow(mask); axis on;
bw = activecontour(I, mask);
% imshow(bw)
for i = 1:size(I, 1)

    for j = 1:size(I, 2)

        if bw(i, j) == 0
            
            I(i, j) = 200;
        end

    end

end

subplot(1, 4, 2); imshow(I); title('remove contour');
% I = imadjust(I, [0.2 1]);
subplot(1, 4, 3); imshow(I); title('enhance contrast'); axis on;

[L, Centers] = imsegkmeans(I, 2);
B = labeloverlay(I, L);
% subplot(1, 4, 4); imshow(B); title('Using K means to segment')
gray = rgb2gray(B);
subplot(1, 4, 4); imshow(gray); title('K means to segment')

figure

% subplot(1, 4, 1); imhist(I); title('');
% BWc1 = imclearborder(B);
% subplot(1, 4, 2); imshow(BWc1);
% after_threshold = I < 60;
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
