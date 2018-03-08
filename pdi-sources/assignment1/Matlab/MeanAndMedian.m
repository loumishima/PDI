function [] = MeanAndMedian(img)

opt = input('digite a ordem dos filtros: \n');

averagingFilter = fspecial('average', opt);
imgMean = imfilter(img, averagingFilter);
imgMedianRed = medfilt2(img(:,:,1), [opt opt]);
imgMedianGreen = medfilt2(img(:,:,2), [opt opt]);
imgMedianBlue = medfilt2(img(:,:,3), [opt opt]);
imgMedian = cat(3,imgMedianRed,imgMedianGreen,imgMedianBlue);

imwrite(imgMean, '17Mean.jpg')
imwrite(imgMedian, '17Median.jpg')

end