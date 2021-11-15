close all
clear all

im = imread('./imgs/squares.png');
imnova = im;

for i = 1:size(imnova, 1)
    for j = 1:size(imnova, 2)
        % se for azul
        if (imnova(i, j, 3) > 220 && imnova(i, j, 1) < 200 && imnova(i, j, 2) < 200)
            % pintar de vermelho
            imnova(i, j, 3) = 0;
            imnova(i, j, 1) = 255;
        end
    end
end

figure(1);
janela = imshow(im);
figure(2);
janela2 = imshow(imnova);

waitfor(janela);
waitfor(janela2);
