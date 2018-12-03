clc
im = imread('pothole1.jpg');
%imshow(im);
%imhist(im);

width = 410;
    dim =size(im);
    im = imresize(im,[width*dim(1)/dim(2) width],'bicubic');
%figure()
imshow(im);
title('Orginal Image');


imgray= rgb2gray(im);
%figure()
imshow(imgray);
title('Rgb to Gray');


im = histeq(imgray);
%figure();
imshow(im);
title('Hist Equelization');

%imenhance = adapthisteq(imgray);
%figure();
%imshow(imenhance);
%title('Adaptive Equalization');

im=gray2bn

imshow(im);































