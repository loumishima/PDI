numberOfImages = 15;
tic
for k = 1 : numberOfImages
  thisImage = imread(['jp2' num2str(k) '.png']); 
  [rows ,columns, numberOfColorBands] = size(thisImage);
  % First do a check for matching rows, columns, and number of color channels.  Then:
  if k == 1
    MedImage(:,:,:,k) = thisImage;
  else
    MedImage(:,:,:,k) = thisImage;
  end
end
Y = median(MedImage, 4);
toc6666
figure, imshow(Y);
imwrite(Y, 'mediana.jpg');