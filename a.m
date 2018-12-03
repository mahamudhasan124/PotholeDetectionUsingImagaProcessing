clc

Image = imread('office_4.jpg');

b=rgb2gray(Image);

h = [1 0 -1; 2 0 -2;1 0 -1];

c = imfilter(b,h);

%edge1 = edge(c,'sobel');


figure(2)
imshow(c);
