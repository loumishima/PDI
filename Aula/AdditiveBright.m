function [] = AdditiveBright(img,YIQ)

opt = input('Defina a quantidade de brilho a ser somado \n');
additiveBright = img + opt;
additiveBrightYIQ = YIQ(:,:,1) + opt/256;
additiveBrightYIQ = cat(3,additiveBrightYIQ,YIQ(:,:,2),YIQ(:,:,3));
additiveBrightYIQ = ntsc2rgb(additiveBrightYIQ);

imwrite(additiveBright, '14RGB.jpg');
imwrite(additiveBrightYIQ, '14YIQ.jpg');


end