clear all
close all

lena = uint8(imread('lena.jpg'));

lena_gray = uint8(lena(:,:,1) * 0.3 + lena(:,:,2) * 0.59 + lena(:,:,3) * 0.11);

lena_gradient = uint8(lena_gray);

for i = 1:size(lena_gradient, 1)
  for j = 1:size(lena_gradient, 2)
    distance_to_mid = 127 - j;
    lena_gradient(i,j) += distance_to_mid;
  endfor
endfor

figure(1);
w = imshow(lena_gray);

figure(2);
w2 = imshow(lena_gradient);

waitfor(w);
waitfor(w2);
