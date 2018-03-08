function [out] = filtromediana_b(im,N)
tic
out = im;
img_R = im(:,:,1);
img_G = im(:,:,2);
img_B = im(:,:,3);

%img = rgb2gray(im);
im_pad = padarray(img_R, [floor(N/2) floor(N/2)]);
im_col = im2col(im_pad, [N N], 'sliding');
M = median(im_col);
M = M.';
out1 = col2im(M, [N N], size(im_pad), 'sliding');

im_pad = padarray(img_G, [floor(N/2) floor(N/2)]);
im_col = im2col(im_pad, [N N], 'sliding');
M = median(im_col);
M = M.';
out2 = col2im(M, [N N], size(im_pad), 'sliding');

im_pad = padarray(img_B, [floor(N/2) floor(N/2)]);
im_col = im2col(im_pad, [N N], 'sliding');
M = median(im_col);
M = M.';
out3 = col2im(M, [N N], size(im_pad), 'sliding');

out(:,:,1) = out1;
out(:,:,2) = out2;
out(:,:,3) = out3;
elapsedTime = toc 
pos1 = [0.1 0.15 0.4 0.7];
subplot('Position',pos1)
imshow(im)
title('Imagem Original')
pos2 = [0.55 0.15 0.4 0.7];
subplot('Position',pos2)
imshow(out)
title('Imagem Filtrada')
end