im = imread('jp.jpg');

tic
imR = im(:,:,1);
imR = im(:,:,2);
imR = im(:,:,3);


imR = im(:,:,1);
imG = im(:,:,2);
imB = im(:,:,3);

B_R = uint8(colfilt(imR,[15 1], 'sliding', @median));
B_G = uint8(colfilt(imG,[15 1], 'sliding', @median));
B_B = uint8(colfilt(imB,[15 1], 'sliding', @median));

B_R = uint8(colfilt(B_R,[1 15], 'sliding', @median));
B_G = uint8(colfilt(B_G,[1 15], 'sliding', @median));
B_B = uint8(colfilt(B_B,[1 15], 'sliding', @median));

result = cat(3,B_R, B_G, B_B);
toc

figure,imshow(result), figure, imshow(im)

