function [] = Limiar(YIQ)

opt = input('1- Opção do usuário | 2-média \n');

switch opt
    case 1
        lim = input('digite o valor de limiar entre 0.0 a 1.0 \n');
        resultLimiar = zeros(size(YIQ(:,:,1)));
        resultLimiar(intersect(find(YIQ(:,:,1) > lim),find(YIQ(:,:,1) < 1.0))) = 1;
        imwrite(resultLimiar, '16User.jpg')
    case 2
        meanY = mean2(YIQ(:,:,1));
        resultLimiar = zeros(size(YIQ(:,:,1)));
        resultLimiar(intersect(find(YIQ(:,:,1) > meanY),find(YIQ(:,:,1) < 1.0))) = 1;
        imwrite(resultLimiar, '16Mean.jpg')


end