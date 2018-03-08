function[YIQ,RGB] = RGBYIQ(img)
%YIQ para RGB e vice-versa
YIQ = rgb2ntsc(img);
%imshow(YIQ)
RGB = ntsc2rgb(YIQ);

imwrite(RGB,'11.jpg');
%imwrite(YIQ,'YIQ.jpg');
end
    