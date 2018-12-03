function ret = CountCoins(img)
 subplot(2,2,1);
 imshow(img);
 subplot(2,2,2);
 imgBW = im2bw(img);
 imshow(imgBW);
 subplot(2,2,3);
 imhist(img);
 subplot(2,2,4);
 imgZ = zeros(size(img));
 imgZ(img > 100) = 1;
 imshow(imgZ);
 ret = round(sum(imgBW(:)) / 2100);
 imgConn = bwconncomp(imgZ);
 ret = imgConn.NumObjects;
end