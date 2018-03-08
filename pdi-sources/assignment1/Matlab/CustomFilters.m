function [] = CustomFilters(img)

filterOne = [0 -1 0; -1 5 -1 ; 0 -1  0];
imgOne = imfilter(img, filterOne);

filterTwo = [ 0 0 0; 0 1 0; 0 0 -1];
imgTwo = imfilter(img, filterTwo);

imwrite(imgOne, '19One.jpg')
imwrite(imgTwo, '19Two.jpg')

end