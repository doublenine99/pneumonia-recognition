% clear; clc; close all;
normal_train_path =  '/Users/TianchangLi/2020 Spring/CS 567/Project/Kaggle/Train/Normal/';
normal_test_path =  '/Users/TianchangLi/2020 Spring/CS 567/Project/Kaggle/Test/Normal/';
bad_path = '/Users/TianchangLi/2020 Spring/CS 567/Project/Kaggle/Test/Bad/';
% 
% % Calculate distribution for normal images
% good_ratio = calculate_ratio(normal_train_path);
% m = mean(good_ratio);
% sd = std(good_ratio);

% Calculate distribution for bad images
% bad_ratio = calculate_ratio(bad_path);
% % Z-test bad images
pred = predict(bad_ratio,m,sd*2*sqrt(size(bad_ratio,1)));
bad_acc = pred./size(bad_ratio,1)
% Calculate distribution for normal images (test)
% good_test_ratio = calculate_ratio(normal_test_path);
% Z-test bad images
pred = predict(good_test_ratio,m,sd*2*sqrt(size(good_ratio,1)));
good_acc = (size(good_test_ratio,1) - pred)./size(good_test_ratio,1)



function ratios = calculate_ratio(path)

    all_images = dir([path '*.jpeg']);
    ratios = zeros(size(all_images));
    size(ratios);
    for k = 1:size(all_images)
        % ratios(i) = 0.1;
        I = imread([path all_images(k).name]);
        % figure

        %%   rescale the image
        row_scale = (300 / size(I, 1));
        col_sclae = 400 / size(I, 2);
        I = imresize(I, [300 400]);
        subplot(1, 5, 1); imshow(I); title('original'); axis on;

        %%   enhance the contrast of image for better segmentation
        I = imadjust(I, [0.4 0.8], [], 0.9);
        subplot(1, 5, 2); imshow(I); title('after adjust'); axis on;

        %%    find the threshold for segmentation from the historgram
        [counts, x] = imhist(I, 100);
        T = otsuthresh(counts);
        BW = imbinarize(I, T);
        subplot(1, 5, 3); imshow(BW); title('After thresholding'); axis on;

        %% Region Growing
        im = ~BW;
        ker = ones(3);
        mask_old = zeros(size(im));
        mask_new = mask_old;
        % left lung seed
        mask_new(100, 150) = 1; %Seed
        mask_new(150, 120) = 1; %Seed
        mask_new(200, 60) = 1; %Seed
        % right lung seed
        mask_new(70, 230) = 1; %Seed
        mask_new(100, 260) = 1; %Seed
        mask_new(110, 240) = 1; %Seed
        mask_new(140, 280) = 1; %Seed
        mask_new(200, 310) = 1; %Seed

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

        subplot(1, 5, 4); imshow(mask_new); title('After region growing'); axis on;

        BW = imfill(mask_new,  'holes');
        subplot(1, 5, 5); imshow(BW); title('After filling'); axis on;
        filtered_lung_size = sum(BW(:));
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

        estimated_lung_area = (right_boundary - left_boundary) * (bottom_boundary - up_boundary);
        ratio = filtered_lung_size / estimated_lung_area;
        ratios(k,:) = ratio;
        size(ratios);
    end

end

function pred = predict(x,mean,sigma)
    pred = 0;
    for i = 1:size(x,1)
        pred = pred + ztest(x(i),mean,sigma,'Alpha',0.95);
    end
end
