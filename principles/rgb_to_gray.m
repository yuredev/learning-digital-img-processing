close all
clear all

lena_rgb = uint8(imread('../imgs/lena.jpg'));

lena_red = lena_rgb(:, :, 1);
lena_blue = lena_rgb(:, :, 2);
lena_green = lena_rgb(:, :, 3);

lena_gray = lena_red * 0.3 + lena_blue * 0.59 + lena_blue * 0.11;

figure(1);
imshow(lena_rgb);

figure(2);
imshow(lena_gray);

# uso isso pois não uso o Octave - GUI e quando rodo por linha
# de comando a janela fecha sozinha sem isso
while (waitforbuttonpress () == 0) pause(1) end