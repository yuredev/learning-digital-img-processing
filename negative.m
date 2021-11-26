clear all
close all

pkg load image

solaire = uint8(imread('./imgs/solaire.jpg'));

figure(1);
imshow(solaire);

luaire = solaire;

for i = 1:size(luaire, 1)
    for j = 1:size(luaire, 2)
        luaire(i, j, :) = 255 - luaire(i, j, :);
    endfor
endfor

figure(2);
imshow(luaire);

# uso isso pois não uso o GUI do Octave e quando executo por linha
# de comando a janela com as imagens fecha sozinha sem isso
while (waitforbuttonpress () == 0) pause(1) end
