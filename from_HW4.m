%% Read img
dir = '/Users/TianchangLi/2020 Spring/CS 567/Project/MaleFemaleRadiograph/data/train/Female/';
prefix = 'rs_0000';
img = imread([dir prefix '0610_001.png']);
db = double(img);
thres = reshape(db < 130, 384, 384);

figure(1);
subplot(2,2,1);
imshow(img); title('original'); axis on;
subplot(2,2,[2 4]);
hist(double(img(:))); title('histgram');
subplot(2,2,3);
imshow(thres); title('post thresholding');
%% Region Growing
im = thres;
ker = ones(3);
mask_old = zeros(size(im));
mask_new = mask_old;
mask_new(100,150) = 1;   %Seed
mask_new(100,300) = 1;   %Seed
% subplot(1,3,3);
% imagesc(mask_new);
mask_size_old = 0;
mask_size_new = 1;
while(mask_size_old ~= mask_size_new)
    mask_old = mask_new;
    mask_size_old = mask_size_new;
    for i=2:size(im,1)-1
        for j=2:size(im,2)-1
            if mask_old(i,j)==1
                mask_new(i-1:i+1,j-1:j+1) = im(i-1:i+1,j-1:j+1).* ker;
            end
        end
    end
    mask_size_new = sum(mask_new(:));
%     pause(0.01);
%     figure(3);
%     subplot(1,3,3);
%     imshow(mask_new);
end

figure(3);
subplot(1,3,1);
imshow(img); title('original');
subplot(1,3,2);
imshow(double(im)); title('post thresholding');
subplot(1,3,3);
imshow(double(mask_new)); title('post region growing');

