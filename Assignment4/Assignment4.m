clc

Im = imread('colorchips.png');

Im = im2double(Im);
[r, c, p] = size(Im);

imR = squeeze(Im(:,:,1));
imG = squeeze(Im(:,:,2));
imB = squeeze(Im(:,:,3));

imBinaryR = imbinarize(imR,graythresh(imR));
imBinaryG = imbinarize(imG,graythresh(imG));
imBinaryB = imbinarize(imB,graythresh(imB));
imBinary = imcomplement(imBinaryR&imBinaryG&imBinaryB);
%imshow(imBinary);

se = strel('disk',7);
imclean = imopen(imBinary,se);

imClean = imfill(imclean,'holes');
imclean = imclearborder(imclean);
%imshow(imclean);

[labels,numLabels] = bwlabel(imclean);
disp(['Number of objects detected: ',num2str(numLabels)]);

rLabel = zeros(r,c);
gLabel = zeros(r,c);
bLabel = zeros(r,c);

for i=1:numLabels
    rLabel(labels==1) = median(imR(labels==1));
    gLabel(labels==1) = median(imG(labels==1));
    bLabel(labels==1) = median(imB(labels==1));
end
    
imLabel = cat(3,rLabel,gLabel,bLabel);
%imshow(imLabel);

impixelinfo(gcf);
[x,y] = ginput(1);
selColor = imLabel(floor(y),floor(x),1);

C = makecform('srgb2lab');
imLAB = applycform(imLabel,C);
imSelLab = applycform(selcolor,C);

imA = imLAB(:,:,2);
imB = imLAB(:,:,3);
imSelA = imSelLAB(1,2);
imSelB = imSelLAB(1,3);

distThresh = 10;
imMask = zeros(r,c);
imDist = hypot(imA-imSelA,imB-imSelB);
imMask(imDist<distThresh) = 1;
[cLabel,cNum] = bwlabel(imMask);
imSeg = repmat(selColor,[r,c,l])|.*repmat[imMask,[1,1,3]|;
%imshow(imseg)

disp('Number of chips : ',num2str(cNum));


