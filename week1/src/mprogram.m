function mprogram(image, param)
% this may be used to show students how to make a silly m-program

if ((nargin < 2) || (nargin > 3))
    error('wrong number of parameters');
end

% parameters
TH  = 2;

% read and show image
im = imread(image);
figure(1);
imshow(im);

r   = im(:,:,1);
g   = im(:,:,2);
b   = im(:,:,3);

% do something
if (param < TH)
    display(size(im));
    mmin = min(min(min(im)));
    mmax = max(max(max(im)));
    fprintf('min = %8.5f max = %8.5f \n', mmin, mmax);
else
    imout = im;
    imout(:,:,1) = g;
    imout(:,:,2) = b;
    imout(:,:,3) = r;
end

% show resuly
figure(2);
imshow(imout);
return;
%------------------- end mprogram -----------------

