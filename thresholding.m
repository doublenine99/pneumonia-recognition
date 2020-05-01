clear; clc; close all;
%% rescale the brightness

%% determine condition to be severe by white area over threshould

I = imread('good.png');
% I = rgb2gray(imread('middle.png'));
% I = (imread('bad.png'));



[counts,x] = imhist(I,16);
stem(x,counts)
T = otsuthresh(counts);
BW = imbinarize(I,T);
figure
imshow(BW)


BW = edge(BW, "Prewitt");
figure
imshow(BW)

