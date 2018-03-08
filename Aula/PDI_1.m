img = imread('tigre.jpg');

%Bandas Monocrom�ticas
red = img(:,:,1);
green = img(:,:,2);
blue = img (:,:,3);

%Bandas separadas e coloridas
a = zeros( size(img,1), size(img,2));
pure_red = cat(3,red,a,a);
pure_green = cat(3,a,green,a);
pure_blue = cat(3,a,a,blue);

%YIQ para RGB e vice-versa
YIQ = rgb2ntsc(img);
RGB = ntsc2rgb(YIQ);

%Negativo
negativeRGB = 255 - img;
negativeYIQ = imcomplement(YIQ(:,:,1));
negativeYIQ = cat(3,negativeYIQ,YIQ(:,:,2),YIQ(:,:,3));

%Brilhos
additiveBright = img + 40;
additiveBrightYIQ = YIQ(:,:,1) + 0.040;
min(YIQ(:,:,1))
additiveBrightYIQ = cat(3,additiveBrightYIQ,YIQ(:,:,2),YIQ(:,:,3));
additiveBrightYIQ = ntsc2rgb(additiveBrightYIQ);
multiplicativeBright = img * 4;

%limiar (definir depois pelo usu�rio)
meanY = mean2(YIQ(:,:,1));
resultLimiar = zeros(size(YIQ(:,:,1)));
resultLimiar(intersect(find(YIQ(:,:,1) > meanY),find(YIQ(:,:,1) < 1.0))) = 1;

%filtro de media e mediana
averagingFilter = fspecial('average', 7);
imgMean = imfilter(img, averagingFilter);
imgMedianRed = medfilt2(img(:,:,1), [7 7]);
imgMedianGreen = medfilt2(img(:,:,2), [7 7]);
imgMedianBlue = medfilt2(img(:,:,3), [7 7]);
imgMedian = cat(3,imgMedianRed,imgMedianGreen,imgMedianBlue);

%filtro laplaciano

sobelFilter = fspecial('sobel');
imgSobel = imfilter(img, sobelFilter);

laplacianFilter = fspecial('laplacian');
imgLaplace = imfilter(img, laplacianFilter);

%filtros custom

filterOne = [0 -1 0; -1 5 -1 ; 0 -1  0];
imgOne = imfilter(img, filterOne);

filterTwo = [ 0 0 0; 0 1 0; 0 0 -1];
imgTwo = imfilter(img, filterTwo);

%filtro 2
%I = imread('eight.tif');
%figure, imshow(I)

%J = imnoise(I,'gaussian');
%figure, imshow(J)

%K = filter2(fspecial('average',3),J)/255;
%figure, imshow(K)

%L = medfilt2(J, [3 3]);
%figure, imshow(L)

%M = imnoise(I,'speckle');
%figure, imshow(M)

%K = filter2(fspecial('average',3),M)/255;
%figure, imshow(K)

%L = medfilt2(M, [3 3]);
%figure, imshow(L)

%prints RGB YIQ
%figure, imshow(img)
%figure, imshow(RGB)

%prints monocromatico

%subplot(2,2,1), imshow(img), title('Imagem Original')
%subplot(2,2,2), imshow(pure_red), title('Faixa monocrom�tica vermelha')
%subplot(2,2,3), imshow(pure_green), title('Faixa monocrom�tica verde')
%subplot(2,2,4), imshow(pure_blue), title('Faixa monocrom�tica azul')

%prints negativo

%figure, subplot(2,1,1), imshow(negativeRGB), title('Negativo RGB')
%subplot(2,1,2), imshow(ntsc2rgb(negativeYIQ)), title('negativo YIQ')

%prints aditivo e multiplicativo

figure, subplot(2,1,1), imshow(additiveBright), title('brilho aditivo')
subplot(2,1,2), imshow(additiveBrightYIQ), title('brilho aditivo YIQ')

%prints limiar

%figure, imshow(resultLimiar), title('limiar')

%prints filtros media e mediana

%figure, subplot(2,1,1), imshow(imgMean), title('M�dia')
%subplot(2,1,2),imshow(imgMedian), title('Mediana')

%prints detec��o de borda (sobel e laplaciano)

%figure, subplot(2,1,1), imshow(imgSobel), title('Sobel')
%subplot(2,1,2),imshow(imgLaplace), title('Laplaciano')

%prints detec��o de borda Matrizes

%figure, subplot(2,1,1), imshow(imgOne), title('Filtro um')
%subplot(2,1,2),imshow(imgTwo), title('Filtro dois')

%print 2




