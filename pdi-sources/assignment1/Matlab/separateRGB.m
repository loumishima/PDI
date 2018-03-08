function [] = separateRGB(img)

opt = input('1- Monocromático | 2 - Colorido \n');

red = img(:,:,1);
green = img(:,:,2);
blue = img (:,:,3);

switch opt
    case 1
        imwrite(red, '12Gred.jpg')
        imwrite(green, '12Ggreen.jpg')
        imwrite(blue, '12Gblue.jpg')
    case 2
        a = zeros( size(img,1), size(img,2));
        pure_red = cat(3,red,a,a);
        pure_green = cat(3,a,green,a);
        pure_blue = cat(3,a,a,blue);
        
        imwrite(pure_red, '12Cred.jpg')
        imwrite(pure_green, '12Cgreen.jpg')
        imwrite(pure_blue, '12Cblue.jpg')
end

end