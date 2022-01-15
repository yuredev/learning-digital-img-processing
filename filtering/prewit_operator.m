clear all
close all

pkg load image

img = rgb2gray(uint8(imread('../imgs/fruits.jpg')));
figure(1);
imshow(img);

rowCount = size(img, 1);
columnCount = size(img, 2);

function pixel = getFilteredPixel(im, i, j)
    prewitFilter = [
        -1 -1 -1;
         0  0  0;
         1  1  1
    ];
    pixel = (
        prewitFilter(1, 1) * im(i - 1, j - 1) +
        prewitFilter(1, 2) * im(i - 1, j) +
        prewitFilter(1, 3) * im(i - 1, j + 1) +
        prewitFilter(2, 1) * im(i, j - 1) +
        prewitFilter(2, 2) * im(i, j) +
        prewitFilter(2, 3) * im(i, j + 1) +
        prewitFilter(3, 1) * im(i + 1, j - 1) +
        prewitFilter(3, 2) * im(i + 1, j) +
        prewitFilter(3, 3) * im(i + 1, j + 1)
    );
    return;
endfunction

filteredImg = uint8(zeros(rowCount, columnCount, 1));

for i = 2: rowCount - 1
    for j = 2: columnCount - 1
        filteredImg(i, j) = getFilteredPixel(img, i, j);
    endfor
endfor

figure(2);
imshow(filteredImg);

while (waitforbuttonpress () == 0) pause(1) end
