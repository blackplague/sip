% Exercise 1.4

% Throws away half of the information
J = I(1:2:end, 1:2:end);

% From image processing
J = imresize(I, 'something') % 'linear' or 'quadratic'