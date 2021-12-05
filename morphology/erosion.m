clear all
close all

pkg load image

img = uint8(imread('../imgs/little_square.jpg'));

rowCount = size(img, 1);
columnCount = size(img, 2);

% Checa se o elemento estruturante em um dado ponto de uma imagem cabe
% o elemento estruturante usado nesta função é:
% 0 1 0
% 1 1 1
% 0 1 0
function result = doesStrElementFit(img, i, j)
    result = (
        img(i - 1, j) == 1 &&
        img(i, j - 1) == 1 &&
        img(i, j) == 1 &&
        img(i, j + 1) == 1 &&
        img(i + 1, j) == 1
    );
    return;
endfunction

img = img < 50;

figure(1);
imshow(img);

edges = zeros(rowCount, columnCount, 1);

% no algoritmo de erosão pegamos as bordas internas
for i = 1:rowCount
    for j = 1:columnCount
        if (img(i, j) == 1 && (~doesStrElementFit(img, i, j)))
            edges(i, j) = 1;
        endif
    end
end

figure(2);
imshow(edges);

erodedImg = img - edges;

figure(3);
imshow(erodedImg);

while (waitforbuttonpress () == 0) pause(1) end
