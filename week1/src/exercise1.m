function exercise1(filepath)

I = imread('images/idotyl.tiff');

%imfinfo('images/idotyl.tiff')

figure('color', 'k'), imshow(I)
figure, [counts, x] = imhist(I);

display('x:')
x

display('Length count:')
length(counts)

img_min = min(min(I))
img_max = max(max(I))

scale = 255. / (double(img_max - img_min)*1.0)

[m,n] = size(I)

M = zeros(m,n);

M(:,:) = floor((I(:,:) - img_min)*scale);

figure, imshow(M, colormap(gray));

imwrite(M, colormap(gray), './images/idotyl_adjusted2.tiff','tiff')

M = imread('./images/idotyl_adjusted2.tiff');
figure, imhist(M, 256)

%imfinfo('./images/idotyl_adjusted2.tiff')