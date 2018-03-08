function[] = SobelAndLaplacian(img)

sobelFilter = fspecial('sobel');
imgSobel = imfilter(img, sobelFilter);

laplacianFilter = fspecial('laplacian');
imgLaplace = imfilter(img, laplacianFilter);

imwrite(imgSobel,'18Sobel.jpg')
imwrite(imgLaplace, '18Laplace.jpg')


end