clc;
clearvars;
close all;
imtool close all; % Close all imtool figures.
workspace;
format longg;
format compact;
fontSize = 20;
tic;
% Read image
original = imread('colorchips.png');
figure,imshow(original)
title('Original Image','FontSize',fontSize);

% RGB component
R=original(:,:,1);
G=original(:,:,2);
B=original(:,:,3);
%figure,imshow(R)
title('Red Component Image','FontSize',fontSize);
%figure,imshow(G)
title('Green Component Image','FontSize',fontSize);
%figure,imshow(B)
title('Blue Component Image','FontSize',fontSize);

% Thresholding
% Select Red compoent
level=graythresh(R);
binary=im2bw(R,level);
figure,imshow(binary)
title('Thresholed Image','FontSize',fontSize);

% Use Morphological Operations 
erosion=imerode(binary,strel('disk',2));
figure,imshow(erosion)
title('Eroded Image','FontSize',fontSize);

% Use Watershed segmentation 
D = bwdist(erosion);
figure
imshow(D,[],'InitialMagnification','fit')
title('Distance transform of ~bw')
D = -D;
D(~erosion) = -Inf;
L = watershed(D);
Lrgb = label2rgb(L,'jet',[.5 .5 .5]);
figure
imshow(Lrgb,'InitialMagnification','fit')
title('Watershed transform of D')
figure,imshow(imfuse(erosion,Lrgb))
axis([])
bw2 = ~bwareaopen(~erosion, 10);
imshow(bw2)
D = -bwdist(~erosion);
figure,imshow(D,[])
Ld = watershed(~D);
figure,imshow(label2rgb(Ld))
bw2 = erosion;
bw2(Ld == 0) = 0;
mask = imextendedmin(D,2);
D2 = imimposemin(D,mask);
Ld2 = watershed(D2);
bw3 = erosion;
bw3(Ld2 == 0) = 0;
figure,imshow(erosion);
title('Watershed Segmentation','FontSize',fontSize)

% labelling 
figure,imshow(original);
title('Labelling','FontSize',fontSize)
s=regionprops(logical(bw3),'Centroid','Area','Eccentricity','Perimeter');
hold on
for k=1:numel(s)
c=s(k).Centroid;
text(c(1),c(2),sprintf('%d',k),...
'HorizontalAlignment','center',...
'VerticalAlignment','middle');
end
hold off

Num = numel(s);
message= sprintf('You have counted %i Strawberries',Num);
h=msgbox(message);