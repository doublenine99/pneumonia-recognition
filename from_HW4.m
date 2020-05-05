clear; close all; clc;
%% Read img
% dir = '/Users/TianchangLi/2020 Spring/CS 567/Project/MaleFemaleRadiograph/data/train/Female/';
% prefix = 'rs_0000';
% img = imread([dir prefix '0610_001.png']);
good = imread('good.png');
middle = imread('middle.png');
middle = rgb2gray(middle);
bad = imread('bad.png');

path =  'C:\Users\pjj85\OneDrive - UW-Madison\2020 Spring\CS 567\567 final project\validation\NORMAL\';
normal_files = dir([path '*.jpeg']);
I = imread([path normal_files(1).name]);

% path =  'C:\Users\pjj85\OneDrive - UW-Madison\2020 Spring\CS 567\567 final project\validation\PNEUMONIA\';
% pne_files = dir([path '*.jpeg']);

% I = imread([path pne_files(5).name]);

row_scale = (300 / size(I, 1));
col_sclae = 400 / size(I, 2);
I = imresize(I, [300 400]);



% TODO: could be paramlized 
I = imadjust(I, [0.4 1]);


figure
imshow(I); title('enhance contrast'); axis on;
% TODO: could be paramlized 
[counts, x] = imhist(I, 100);
T = otsuthresh(counts);
T = graythresh(I)
BW = imbinarize(I, T);
% BW = imbinarize(I, 'adaptive');


figure;
subplot(2, 2, 1);
imshow(I); title('original'); axis on;
subplot(2, 2, [2 4]);
stem(x, counts); title('histgram');
subplot(2, 2, 3);

imshow(BW); title('post thresholding'); axis on;

%% Region Growing
im = ~BW;
ker = ones(3);
mask_old = zeros(size(im));
mask_new = mask_old;

% left lung seed
mask_new(100, 150) = 1; %Seed
mask_new(150,120) = 1;   %Seed
mask_new(200, 60) = 1; %Seed
% right lung seed
mask_new(70, 230) = 1; %Seed
mask_new(110,240) = 1;   %Seed
mask_new(200, 310) = 1; %Seed

% mask_new(130,240) = 1;   %Seed
% subplot(1,3,3);
% imagesc(mask_new);
mask_size_old = 0;
mask_size_new = 1;

while (mask_size_old ~= mask_size_new)
    mask_old = mask_new;
    mask_size_old = mask_size_new;

    for i = 2:size(im, 1) - 1

        for j = 2:size(im, 2) - 1

            if mask_old(i, j) == 1
                mask_new(i - 1:i + 1, j - 1:j + 1) = im(i - 1:i + 1, j - 1:j + 1) .* ker;
            end

        end

    end
    mask_size_new = sum(mask_new(:));
end

figure;
subplot(1, 3, 1);
imshow(I); title('original'); axis on;
subplot(1, 3, 2);
imshow(double(im)); title('post thresholding'); axis on;
subplot(1, 3, 3);
imshow(mask_new); title('post region growing');
BW = imfill(mask_new,  'holes');
% BW = edge(mask_new,  "Prewitt");
figure
imshow(BW); title("after filled")

filtered_lung_size = sum(BW(:))

left_boundary = 500;
right_boundary = 0;
up_boundary = 500;
bottom_boundary = 0;

for row = 1:size(BW, 1)

    for col = 1:size(BW, 2)

        if BW(row, col) == 1 && col < left_boundary
            left_boundary = col;
        end

        if BW(row, col) == 1 && col > right_boundary
            right_boundary = col;
        end

        if BW(row, col) == 1 && row < up_boundary
            up_boundary = row;
        end

        if BW(row, col) == 1 && row > bottom_boundary
            bottom_boundary = row;
        end

    end

end

left_boundary 
right_boundary
up_boundary 
bottom_boundary 

estimated_lung_area = (right_boundary - left_boundary) * (bottom_boundary - up_boundary)
ratio = filtered_lung_size / estimated_lung_area