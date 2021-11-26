clear all
close all

pkg load image

artorias = uint8(imread('./imgs/artorias.jpg'));

figure(1);
imshow(artorias);
title ({"Imagem original"});

rowCount = size(artorias, 1);
collumnCount = size(artorias, 2);

% >>>>>>>>>>>>>>>>>>> RIGHT FLIP <<<<<<<<<<<<<<<<<<<<

artoriasRightFlip = uint8(zeros(collumnCount, rowCount, 3)); 

for i=1:rowCount
    for j=1:collumnCount
        artoriasRightFlip(j, i, :) = artorias(rowCount + 1 - i, j, :);
    endfor
endfor

figure(2);
imshow(artoriasRightFlip);
title ({"Imagem girada pra direita"});

% >>>>>>>>>>>>>>>>>>> LEFT FLIP <<<<<<<<<<<<<<<<<<<<

artoriasLeftFlip = uint8(zeros(collumnCount, rowCount, 3)); 

for i=1:rowCount
    for j=1:collumnCount
        artoriasLeftFlip(j, i, :) = artorias(i, j, :);
    endfor
endfor

figure(3);
imshow(artoriasLeftFlip);
title ({"Imagem girada pra esquerda"});

% >>>>>>>>>>>>>>>>>> FULL FLIP <<<<<<<<<<<<<<<<<<<<<<<

artoriasFullFlip = uint8(zeros(rowCount, collumnCount, 3));

for i=1:rowCount
    for j=1:collumnCount
        artoriasFullFlip(i, j, :) = artorias(rowCount + 1 - i, collumnCount + 1 - j, :);
    endfor
endfor

figure(4);
imshow(artoriasFullFlip);
title ({"Imagem totalmente girada"});

# uso isso pois não uso o GUI do Octave e quando executo por linha
# de comando a janela com as imagens fecha sozinha sem isso
while (waitforbuttonpress () == 0) pause(1) end
