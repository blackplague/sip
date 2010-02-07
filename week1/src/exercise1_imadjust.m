function exercise1_imadjust(filepath)

I = imread('images/idotyl.tiff');

figure('color', 'k')
% Unadjusted picture
imshow(I)
%colormap()
% Adjusting the picture
M = imadjust(I); % imadjust(I, [low_in; high_in], [low_out; high_out], ???)

figure
imshow(M)

imwrite(M, 'images/' + 'idotyl'+'_adjusted','tiff')


