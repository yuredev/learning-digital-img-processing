clear all
close all

pkg load image

img = uint8(imread('../imgs/halo_infinite.jpeg'));
figure(1);
imshow(img);

rowCount = size(img, 1);
columnCount = size(img, 2);

function pixel = getPixelFiltered(im, i, j)
    imgFilter = [
        -1 -1 -1;
        -1 8 -1;
        -1 -1 -1
    ];
    pixel = (
        imgFilter(1, 1) * im(i - 1, j - 1, :) +
        imgFilter(1, 2) * im(i - 1, j, :) +
        imgFilter(1, 3) * im(i - 1, j + 1, :) +
        imgFilter(2, 1) * im(i, j - 1, :) +
        imgFilter(2, 2) * im(i, j, :) +
        imgFilter(2, 3) * im(i, j + 1, :) +
        imgFilter(3, 1) * im(i + 1, j - 1, :) +
        imgFilter(3, 2) * im(i + 1, j, :) +
        imgFilter(3, 3) * im(i + 1, j + 1, :)
    );
    return;
endfunction

filteredImg = zeros(rowCount, columnCount, 3);

for i = 2: rowCount - 1
    for j = 2: columnCount - 1
        filteredImg(i, j, :) = getPixelFiltered(img, i, j);
    endfor
endfor

figure(2);
imshow(filteredImg);

while (waitforbuttonpress () == 0) pause(1) end
