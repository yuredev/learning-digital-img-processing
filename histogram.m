# a função imhist serve para mostrar o histograma de uma imagem
# esta função retorna um vetor onde cada elemento é a quantidade de pixels daquela intensidade
clear all
close all

pkg load image

lenaRgb = uint8(imread('./imgs/lena.jpg'));
lenaGray = rgb2gray(lenaRgb);

figure(1);
imshow(lenaGray);

figure(2);
imhist(lenaGray);

# uso isso pois não uso o Octave - GUI e quando rodo por linha
# de comando a janela fecha sozinha sem isso
while (waitforbuttonpress () == 0) pause(1) end
