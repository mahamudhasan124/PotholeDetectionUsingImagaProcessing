clc

i = imread('pothole1.jpg');
width = 210;
    dim =size(i);
    i = imresize(i,[width*dim(1)/dim(2) width],'bicubic');
    figure(1);
    imshow(i),title('Orginal Image');
    
    
    i =rgb2gray(i);
    figure(2);
    imshow(i);
    title('Rgb to Gray');
    
    imhist(i);
    
    i = histeq(i);
    imhist(i);
    figure(3)
imshow(i);
title('Hist Equelization');

i= im2bw(i);
figure(4)
imshow(i);
title('Binary Image');

%Remove Noise
k = wiener2(i,[5 5]);
figure(5)
imshow(k)
title('Noise Remove');

i = imdilate(k,strel('disk',3));
i=i-k;

i=1-i;
figure(6)
imshow(i)
title('Only Area');






