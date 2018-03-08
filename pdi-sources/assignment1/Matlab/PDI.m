n = input('Selecione uma opção de 11 a 20, onde cada valor é um exercício do trabalho: \n');
img = imread('tigre.jpg');
switch n
    case 11
        RGBYIQ(img);
    case 12
        separateRGB(img);
    case 13
        [YIQ,RGB] = RGBYIQ(img);
        Negative(img,YIQ);
    case 14
        [YIQ,RGB] = RGBYIQ(img);
        AdditiveBright(img,YIQ);
    case 15
        [YIQ,RGB] = RGBYIQ(img);
        MultiplicativeBright(img,YIQ);
    case 16
        [YIQ,RGB] = RGBYIQ(img);
        Limiar(YIQ);
    case 17
        MeanAndMedian(img);
    case 18
        SobelAndLaplacian(img);
    case 19
        CustomFilters(img);
    case 20
        Coins();
end



