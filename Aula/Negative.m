function [] =  Negative(img,YIQ)

negativeRGB = 255 - img;
negativeYIQ = imcomplement(YIQ(:,:,1));
negativeYIQ = cat(3,negativeYIQ,YIQ(:,:,2),YIQ(:,:,3));
negativeYIQ = ntsc2rgb(negativeYIQ);

imwrite(negativeRGB, '13NRGB.jpg')
imwrite(negativeYIQ, '13NYIQ.jpg')
end