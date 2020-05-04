clear; clc; close all;
%% rescale the brightness

%% determine condition to be severe by white area over threshould

I = imread('good.png');
% I = rgb2gray(imread('middle.png'));
I = (imread('bad.png'));

% I = imadjust(I, [0.7 1]);
% figure
% imshow(I); title('enhance contrast'); axis on;
  
[counts,x] = imhist(I,30);
stem(x,counts)
T = otsuthresh(counts);
BW = imbinarize(I,T);
% size(BW)
inversed = (255) - (BW .* 255);
figure
imshow(inversed); axis on;


% white = I < 150;
% figure
% imshow(white);

BW = edge(BW, "Prewitt"); 
figure
imshow(BW)

