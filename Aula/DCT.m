img = [ 5 13; 14 21]

%result = dct2(img)

%result = dct2(img(2,:));

%invert = idct2(result(2,:))

result = fft2(img)

result2 = fft(img(2,:))

invert = ifft2(result)