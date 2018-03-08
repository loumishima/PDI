img = imread('img2.jpg');

max(imgG(:))
min(imgG(:))
imgG = rgb2gray(img);
imgHEq = histeq(imgG);
Ex = stretchlim(imgG, 0);
imgHEx = imadjust(imgG, Ex, []);

diference = abs(imgG - imgHEx);
diference2 = abs(imgHEq - imgHEx);

%imshowpair(imgG, imgHEx, 'montage');
%figure, imshowpair(imgHEq, imgHEx, 'montage');
%figure, imshow(diference); %difference between Expansion and Original
%figure, imshow(diference2); %difference between Expansion and Equalization

imwrite(imgG, 'imgG.jpg');
imwrite(imgHEx, 'imgHEx.jpg');
imwrite(imgHEq, 'imgHEq.jpg');

