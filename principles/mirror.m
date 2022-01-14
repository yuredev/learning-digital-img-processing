clear all
close all

pkg load image

solaire = uint8(imread('../imgs/solaire.jpg'));

figure(1);
imshow(solaire);

rowCount = size(solaire, 1);
collumnCount = size(solaire, 2);

solaireReflex = uint8(zeros(rowCount, collumnCount, 3));

for i = 1:rowCount
    for j = 1:collumnCount
        solaireReflex(i, j, :) = solaire(i, (collumnCount + 1) - j, :);
    endfor
endfor

figure(2);
imshow(solaireReflex);

solaire_vert = uint8(zeros(rowCount, collumnCount, 3));

for i=1:rowCount
    for j=1:collumnCount
        solaire_vert(i, j, :) = solaire((rowCount + 1) - i, j, :); 
    endfor
endfor

figure(3);
imshow(solaire_vert);


# uso isso pois não uso o GUI do Octave e quando executo por linha
# de comando a janela com as imagens fecha sozinha sem isso
while (waitforbuttonpress () == 0) pause(1) end
solaire_reflex
solaire_reflex
solaire_reflex