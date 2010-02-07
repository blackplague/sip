function man_exer(gray_reduce)

I = imread('./images/idotyl.tiff');

figure, imshow(I)
%imfinfo('./images/idotyl.tiff')

%figure, imshow(I)
%figure, imhist(I, 256)

img_min = min(min(I));
img_max = max(max(I));

scale = 1.0-gray_reduce

[m,n] = size(I);

% Get histogram of image, incl. bin counts
[counts, x] = imhist(I);

M = zeros(m,n);

M(:,:) = floor(I(:,:)*scale);

M_max = max(max(M))

figure, imshow(M, colormap(gray));

imwrite(M, colormap(gray), './images/idotyl_adjusted2.tiff','tiff')

M = imread('./images/idotyl_adjusted2.tiff');
figure, imhist(M, 256)

%imfinfo('./images/idotyl_adjusted2.tiff')

end