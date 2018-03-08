img = imread('jp.jpg');

h3_1 = ones(3,1) / 3;
h25_1 = ones(25,1) / (25*1);

h1_25 = ones(25,1) / (25*1);
h1_3 = ones(1,3) / (1*3);

% img com filtro 3 x 3
tic
imgMean3_1 = imfilter(img,h3_1);
imgMean3_3 = imfilter(imgMean3_1, h1_3);
toc
% img com filtro 3 x 25
tic
imgMean3_1 = imfilter(img,h3_1);
imgMean3_25 = imfilter(imgMean3_1, h1_25);
toc
% img com filtro 25 x 3
tic
imgMean25_1 = imfilter(img,h25_1);
imgMean25_3 = imfilter(imgMean25_1, h1_25);
toc
% img com filtro 25 x 25
tic
imgMean25_1 = imfilter(img,h25_1);
imgMean25_25 = imfilter(imgMean25_1, h1_25);
toc



imwrite(imgMean3_3,'_imgM3x3.jpg') 
imwrite(imgMean3_25,'_imgM3x25.jpg')
imwrite(imgMean25_3,'_imgM25x3.jpg')
imwrite(imgMean25_25,'_imgM25x25.jpg')