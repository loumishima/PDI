im = imread('1.jpg');
im_g = rgb2gray(im);
%B = input('selecione a grandeza do bloco de busca');

points = detectSURFFeatures(im_g);

imshow(im); hold on;
plot(points.selectStrongest(10));