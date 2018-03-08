function[] = Coins()

I = imread('eight.tif');

J = imnoise(I,'gaussian');
imwrite(J, '20gauss.jpg');

K = filter2(fspecial('average',3),J)/255;
imwrite(K, '20gaussMean.jpg');

L = medfilt2(J, [3 3]);
imwrite(L, '20gaussMedian.jpg');

M = imnoise(I,'speckle');
imwrite(M,'20speckle.jpg');

K = filter2(fspecial('average',3),M)/255;
imwrite(K, '20speckleMean.jpg');

L = medfilt2(M, [3 3]);
imwrite(L, '20speckleMedian.jpg');



end