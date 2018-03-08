%img = imread('jp2.jpg');

%for k = 1:15
    %r = abs((1/10 * rand(1,1)));
    %I = imnoise(img, 'salt & pepper',r);
    %nameFile = sprintf('jp2%d.png', k);
    %imwrite(I, nameFile);
%end
numberOfImages = 15;
for k = 1 : numberOfImages
  thisImage = double(imread(['jp2' num2str(k) '.png'])); 
  [rows ,columns, numberOfColorBands] = size(thisImage);
  
  if k == 1
    sumImage = thisImage;
  else
    sumImage = sumImage + thisImage;
  end
end
sumImage = sumImage / numberOfImages;
sumImage = uint8(sumImage);
figure, imshow(sumImage);
imwrite(sumImage, 'media.jpg');