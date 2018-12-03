clc

image = imread('colorchips.png');


figure,imshow(image);

redchip = image(:,:,1);



%figure,imshow(redchip)

%histogram(red);

black=(redchip<51);
black=(black*0);

white = (redchip>50);
white = (white*255);

redchip=black+white;

[labels,numLabels] = bwlabel(redchip);
disp(['',num2str(numLabels)+2]);




