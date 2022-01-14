clear all
close all

lena = uint8(imread('../imgs/lena.jpg'));

lena_gray = lena(:, :, 1) * 0.3 + lena(:, :, 2) * 0.59 + lena(:, :, 3) * 0.11;

lena_gradient = uint8(lena_gray);

for i = 1:size(lena_gradient, 1)
    for j = 1:size(lena_gradient, 2)
        distance_to_mid = 127 - j;
        lena_gradient(i, j) += distance_to_mid;
    endfor
endfor

figure(1);
imshow(lena_gray);

figure(2);
imshow(lena_gradient);

# uso isso pois não uso o Octave - GUI e quando rodo por linha
# de comando a janela fecha sozinha sem isso
while (waitforbuttonpress () == 0) pause(1) end
