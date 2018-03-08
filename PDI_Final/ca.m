function[] = ca( filename, aR, aB )%Arquivo, tom de vermelho, tom de azul

    im = double( imread( filename ) );
    [ydim,xdim,zdim] = size( im );
    imCA = im;
    imCA(:,:,1) = scaleim( imCA(:,:,1), aR ); %reorganização da banda vermelha
    imCA(:,:,3) = scaleim( imCA(:,:,3), aB ); %reorganização da banda azul

    k = 1;
    green = imCA(:,:,2); %banda verde
    for alpha = [0.80 : 0.02 : 1.20] % alpha entre 0.8 e 1.2
        red = scaleim( imCA(:,:,1), 1/alpha ); %reorganiza pelo fator alpha 
        ind = find( red > 0 ); %encontra valores maiores que zero
        C(k,1) = corr2( red(ind), green(ind) ); %correlação entre vermelho e verde
        blue = scaleim( imCA(:,:,3), 1/alpha ); %reorganiza pelo fator alpha 
        ind = find( blue > 0 ); %valores não nulos na banda azul
        C(k,2) = corr2( blue, green ); %correlação entre azul e verde
        C(k,3) = alpha;
    k = k + 1;
end
%%% REMOVE ESTIMATED CHROMATIC ABERRATIONS
    [maxval,maxindR] = max(C(:,1)); %retorna maior correlação verm/verde
    [maxval,maxindG] = max(C(:,2)); %retorna maior correlação azul/verde
    alphaR = C(maxindR,3);
    alphaG = C(maxindG,3);
    imCORRECT = imCA;
    imCORRECT(:,:,1) = scaleim( imCA(:,:,1), 1/alphaR ); %reorganização com novo alpha vermelho
    imCORRECT(:,:,3) = scaleim( imCA(:,:,3), 1/alphaG ); %reorganização com novo alpha verde
    imagesc( uint8([im imCA ]) ); axis image off;

    
   
%%% SCALE IMAGE BY A FACTOR OF ALPHA
function[im2] = scaleim( im, alpha )
[ydim,xdim,zdim] = size(im);
if( alpha > 1 ) % central crop to match size(im)
    im2 = imresize( im, alpha );
    [ydim2,xdim2,zdim2] = size(im2);
    cy = floor( (ydim2-ydim)/2 ); %centro em y
    cx = floor( (xdim2-xdim)/2 ); %centro em x
    im2 = im2( cy+1:ydim2-cy, cx+1:xdim2-cx, : ); % corte
    im2 = imresize( im2, [ydim xdim] ); % ajuste de tamanho
else 
    im2 = imresize( im, alpha );
    [ydim2,xdim2,zdim2] = size( im2 );
    im3 = zeros( ydim, xdim, zdim );
    cy = floor( (ydim-ydim2)/2 );
    cx = floor( (xdim-xdim2)/2 );
    im3( [1:ydim2]+cy, [1:xdim2]+cx, : ) = im2;
    im2 = im3;
end