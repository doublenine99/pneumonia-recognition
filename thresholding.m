clear; clc; close all;
%% rescale the brightness

%% determine condition to be severe by white area over threshould

% I = imread('good.png');
% I = rgb2gray(imread('middle.png'));
% I = (imread('bad.png'));
path = 'C:\Users\pjj85\OneDrive - UW-Madison\2020 Spring\CS 567\567 final project\validation\NORMAL\'
files=dir([path '*.jpeg']);
I=imread([path files(1).name]);

I = imadjust(I, [0.2 1]);
% I = imgaussfilt(I,4);
figure
imshow(I); title('enhance contrast'); axis on;
  
figure
[counts,x] = imhist(I,5);
stem(x,counts)
T = otsuthresh(counts);
BW = imbinarize(I,T);
% size(BW)
inversed = (255) - (BW .* 255);
figure
imshow(inversed); axis on;



% [L, Centers] = imsegkmeans(I,3);
% B = labeloverlay(I, L);
% % subplot(1, 4, 4); imshow(B); title('Using K means to segment')
% gray = rgb2gray(B);
% figure; imshow(gray); title('K means to segment')


% BW = edge(I, "sobel"); 
% figure
% imshow(BW)

