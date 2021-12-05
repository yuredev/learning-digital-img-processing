clear all
close all

pkg load image

img = uint8(imread('../imgs/little_square.jpg'));

rowCount = size(img, 1);
columnCount = size(img, 2);

img = img < 50;

figure(1);
imshow(img);

edges = zeros(rowCount, columnCount, 1);

% no algoritmo de dilatação pegamos as bordas externas
for i = 1:rowCount
    for j = 1:columnCount
        if img(i, j) == 1
            if img(i - 1, j - 1) != 1
                edges(i - 1, j - 1) = 1;
            end
            if img(i - 1, j) != 1
                edges(i - 1, j) = 1;
            end
            if img(i - 1, j + 1) != 1
                edges(i - 1, j + 1) = 1;
            end
            if img(i, j - 1) != 1
                edges(i, j - 1) = 1;
            end
            if img(i, j) != 1
                edges(i, j) = 1;
            end
            if img(i, j + 1) != 1
                edges(i, j + 1) = 1;
            end
            if img(i + 1, j - 1) != 1
                edges(i + 1, j - 1) = 1;
            end
            if img(i + 1, j) != 1
                edges(i + 1, j) = 1;
            end
             if img(i + 1, j + 1) != 1
                edges(i + 1, j + 1) = 1;
            end
        endif
    end
end

figure(2);
imshow(edges);

dilatedImage = img + edges;

figure(3);
imshow(dilatedImage);

while (waitforbuttonpress () == 0) pause(1) end
