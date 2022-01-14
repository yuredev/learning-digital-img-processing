clear all
close all

pkg load image

photo8 = uint8(imread('../imgs/test_01/foto8.jpg'));

rowCount = size(photo8, 1);
collumnCount = size(photo8, 2);

% ----------------------------------- invertendo lados

reversedSides = uint8(zeros(rowCount, collumnCount, 3));

for i = 1:rowCount
    for j = 1:collumnCount
        if (j <= collumnCount / 2)
            reversedSides(i, j, :) = photo8(i, j + collumnCount / 2, :);
        else
            reversedSides(i, j, :) = photo8(i, j - collumnCount / 2, :);
        endif
    end
end

% ----------------------------------- espelhar lado direito

rightMirrowed = reversedSides;

for i = 1:rowCount
    for j = collumnCount / 2 + 1:collumnCount
        rightMirrowed(i, j, :) = reversedSides(i, collumnCount - j + collumnCount / 2, :);
    end
end

% ----------------------------------- passando listras negativas

negativeStripes = rightMirrowed;

% listras horizontais
for j = 1:collumnCount
    for i = 9:19
        negativeStripes(i, j, :) = 255 - negativeStripes(i, j, :);
        negativeStripes(rowCount - i, j, :) = 255 - negativeStripes(rowCount - i, j, :);
    end
end

% listras verticais
for i = 1:rowCount
    for j = 9:19
        if (i >= 9 && i <= 19 || i >= rowCount - 19 && i <= rowCount - 9)
            continue
        endif
        negativeStripes(i, j, :) = 255 - negativeStripes(i, j, :);
        negativeStripes(i, collumnCount - j, :) = 255 - negativeStripes(i, collumnCount - j, :);
    end
end

% --------------------------------- aplicar máscara

mask = uint8(imread('../imgs/test_01/mascara4.jpg'));
maskFixed = zeros(rowCount, collumnCount, 3);

% deixar tudo que não vai pra o resultado final preto
% marcar quadrados com 400 que é só uma flag, pra depois eu identificar a região
for i = 1:rowCount
    for j = 1:collumnCount
        if (mask(i, j) < 110)
            maskFixed(i, j, :) = 0;
        else
            if (mask(i, j) > 120 && mask(i, j) < 140)

                maskFixed(i, j, 1) = 400;
                maskFixed(i, j, 2) = 0;
                maskFixed(i, j, 3) = 0;
            else
                if (mask(i, j) > 180 && mask(i, j) < 200)
                    maskFixed(i, j, 1) = 0;
                    maskFixed(i, j, 2) = 400;
                    maskFixed(i, j, 3) = 0;
                else
                    % manter as bordas brancas
                    maskFixed(i, j, :) = 255;
                endif
            endif
        endif
    end
end

% juntar imagem com a máscara
maskedImg = negativeStripes + maskFixed;

for i = 1:rowCount
    for j = 1:collumnCount
        %  pintar de vermelho
        if (maskFixed(i, j, 1) == 400 && maskFixed(i, j, 2) == 0 && maskFixed(i, j, 3) == 0)
            maskedImg(i, j, 1) = 255;
            maskedImg(i, j, 2) = 0;
            maskedImg(i, j, 3) = 0;
        end
        %  pintar de verde
        if (maskFixed(i, j, 1) == 0 && maskFixed(i, j, 2) == 400 && maskFixed(i, j, 3) == 0)
            maskedImg(i, j, 1) = 0;
            maskedImg(i, j, 2) = 255;
            maskedImg(i, j, 3) = 0;
        end
    end
end

% ---------------------- colocar img8 dentro do quadrado pintado de verde

colorsImg = uint8(imread('../imgs/test_01/img8.jpg'));
merged = maskedImg;

for i = 1:rowCount
    for j = 1:collumnCount
        if (maskedImg(i, j, 1) == 0 && maskedImg(i, j, 2) == 255 && maskedImg(i, j, 3) == 0)
            merged(i, j, :) = colorsImg(i, j, :);
        end
        if (maskedImg(i, j, 1) == 255 && maskedImg(i, j, 2) == 0 && maskedImg(i, j, 3) == 0)
            merged(i, j, :) = 0;
        end
    end
end

% ------------------------------------------------ manipular assinatura

signature = uint8(imread('../imgs/test_01/ass.jpg'));

% negativar assinatura
% obs: fiz direto pois já usei o negativo manual anteriormente
negSignature = uint8(255 - signature);

gradientSignature = negSignature;

% aplicar gradiente
decrease = 255;
for j = 1:size(gradientSignature, 2)
    for i = 1:size(gradientSignature, 1)
        if (decrease > 0)
            gradientSignature(i, j) -= decrease;
        end
    end
    decrease -= 5;
end

% -------------------------------------------- colocar assinatura

imgSigned = merged;

for i = 1:size(gradientSignature, 1)
    for j = 1:size(gradientSignature, 2)
        imgSigned(i + 175, j + 130, :) = gradientSignature(i, j, :);
    end
end

figure(1);
imshow(imgSigned);

# uso isso pois não uso o Octave(GUI) e quando executo pelo terminal
% as janelas com as imagens fecham sozinhas sem isso
while (waitforbuttonpress () == 0) pause(1) end
