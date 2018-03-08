function [] = MultiplicativeBright(img,YIQ)

opt = input('Defina a quantidade de brilho a ser multiplicado \n');
multBright = img * opt;
multBrightYIQ = YIQ(:,:,1) * opt;
multBrightYIQ = cat(3,multBrightYIQ,YIQ(:,:,2),YIQ(:,:,3));
multBrightYIQ = ntsc2rgb(multBrightYIQ);

imwrite(multBright, '15RGB.jpg');
imwrite(multBrightYIQ, '15YIQ.jpg');




end