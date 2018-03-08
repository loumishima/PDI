img = imread('jp.jpg');

h3_3 = ones(3,3) / 9;
h3_25 = ones(3,25) / (3*25);
h25_3 = ones(25,3) / (25*3);
h25_25 = ones(25,25) / (25*25);

tic
x_imgMean3_3 =  imfilter(img, h3_3);
toc
tic
x_imgMean3_25 =  imfilter(img, h3_25);
toc
tic
x_imgMean25_3 =  imfilter(img, h25_3);
toc
tic
x_imgMean25_25 =  imfilter(img, h25_25);
toc


imwrite(x_imgMean3_3, 'imgM3x3.jpg') 
imwrite(x_imgMean3_25, 'imgM3x25.jpg')
imwrite(x_imgMean25_3,'imgM25x3.jpg')
imwrite(x_imgMean25_25,'imgM25x25.jpg')

