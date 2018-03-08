img = imread('jp.jpg');

%tic
%imgMedianRed = medfilt2(img(:,:,1), [15 15]);
%imgMedianGreen = medfilt2(img(:,:,2), [15 15]);
%imgMedianBlue = medfilt2(img(:,:,3), [15 15]);
%imgMedian = cat(3,imgMedianRed,imgMedianGreen,imgMedianBlue);
%imshow(imgMedian);

%toc

tic

imR = im(:,:,1);
imG = im(:,:,2);
imB = im(:,:,3);

B_R = uint8(colfilt(imR,[15 15], 'sliding', @median));
B_G = uint8(colfilt(imG,[15 15], 'sliding', @median));
B_B = uint8(colfilt(imB,[15 15], 'sliding', @median));

result = cat(3,B_R, B_G, B_B);
toc

figure,imshow(result), figure, imshow(im)

