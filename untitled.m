cd 'C:\Users\Kaushi\Downloads'
load('PaviaU.mat');
load('paviaU_7gt.mat'); 
load('paviaC.mat')
load('paviaC_7gt.mat')
whos
size(ori_data)        
size(map)     

imshow(ori_data(:,:,1), []);
title('Hyperspectral Image - Band 1')
imshow(map, []); 
title('Ground Truth - Classification Map');


rgb_image = cat(3, ori_data(:,:,30), ori_data(:,:,60), ori_data(:,:,90));
imshow(rgb_image, []);
title('False Color Composite (Bands 30, 60, 90)');

[rows, cols, bands] = size(ori_data);
X = reshape(ori_data, rows * cols, bands);
X_mean = mean(X, 1);          
X_std = std(X, 0, 1);         
X_standardized = (X - X_mean) ./ X_std; 
[coeff, score, explained] = pca(X_standardized);
plot(cumsum(explained), '-o');
xlabel('Number of Principal Components');
ylabel('Cumulative Variance Explained (%)');
title('PCA Variance Explained');
grid on;
num_components = 3;
pca_image = reshape(score(:, 1:num_components), [rows, cols, num_components]);

for i = 1:num_components
    figure;
    imshow(pca_image(:,:,i), []);
    title(['Principal Component ', num2str(i)]);
end

rgb_pca = pca_image(:,:,1:3);
rgb_pca = mat2gray(rgb_pca); 
figure;
imshow(rgb_pca);
title('PCA False-Color Composite');


X_pca = score(:, 1:10); 








