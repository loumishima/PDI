image = imread('1.jpg');

im = rgb2gray(image);

[Gx, Gy] = imgradientxy(im);

imshowpair(Gx,Gy);
figure, imshow(im);