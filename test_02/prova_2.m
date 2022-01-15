pkg load image

clear all
close all

% -------------------------------- questao 1

im = uint8(imread('../imgs/test_02/cores.jpg'));

rowCount = size(im, 1);
columnCount = size(im, 2);

newImg = logical(zeros(rowCount, columnCount));

for i = 1:rowCount
    for j = 1:columnCount
        if (
            im(i, j, 1) > 220 && im(i, j, 2) < 50 && im(i, j, 3) < 50 || % vermelho
            im(i, j, 1) < 30 && im(i, j, 2) > 220 && im(i, j, 3) > 230% ciano
            )
            newImg(i, j) = true;
        endif
    endfor
endfor

function result = getExternalEdges(img)
    edges = logical(zeros(size(img, 1), size(img, 2), 1));

    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
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

                if img(i - 2, j - 1) != 1
                    edges(i - 2, j - 1) = 1;
                end
                if img(i - 2, j) != 1
                    edges(i - 2, j) = 1;
                end
                if img(i - 2, j + 1) != 1
                    edges(i - 2, j + 1) = 1;
                end
                % ----------
                if img(i - 1, j + 2) != 1
                    edges(i - 1, j + 2) = 1;
                end
                if img(i, j + 2) != 1
                    edges(i, j + 2) = 1;
                end
                if img(i + 1, j + 2) != 1
                    edges(i + 1, j + 2) = 1;
                end
                % ----------
                if img(i + 2, j - 1) != 1
                    edges(i + 2, j - 1) = 1;
                end
                if img(i + 2, j) != 1
                    edges(i + 2, j) = 1;
                end
                if img(i + 2, j + 1) != 1
                    edges(i + 2, j + 1) = 1;
                end
                % ----------
                if img(i - 1, j - 2) != 1
                    edges(i - 1, j - 2) = 1;
                end
                if img(i, j - 2) != 1
                    edges(i, j - 2) = 1;
                end
                if img(i + 1, j - 2) != 1
                    edges(i + 1, j - 2) = 1;
                end
            endif
        end
    end
    result = edges;
    return;
endfunction

externalEdges = getExternalEdges(newImg);

figure(1)
imshow(externalEdges);

% -------------------------------- questao 2

rgbFinalImg = uint8(zeros(rowCount, columnCount, 3));

for i=1:rowCount
    for j=1: columnCount
        if externalEdges(i, j)
            rgbFinalImg(i, j, :) = 0;
        else
            if (
                im(i, j, 1) > 220 && im(i, j, 2) < 50 && im(i, j, 3) < 50 || % vermelho
                im(i, j, 1) < 30 && im(i, j, 2) > 220 && im(i, j, 3) > 230% ciano
            )
                rgbFinalImg(i, j, :) = im(i, j, :);
            else
                rgbFinalImg(i, j, :) = 255;
            endif
        endif
    endfor
endfor

figure(2);
imshow(rgbFinalImg);

% ---------------------------------- questao 3

input2 = uint8(imread('../imgs/test_02/ruido2.jpg')); 

function pixel = getOrder9Value(im, i, j)
    neighborMatrix = im(i - 2: i + 2, j - 2: j +2);
    neighborVec = reshape(neighborMatrix, 1, []); % transformar em vetor
    pixel = sort(neighborVec)(9);
    return;
endfunction

smoothed = uint8(zeros(size(input2, 1), size(input2, 3)));

for i=3: size(input2, 1) - 2
    for j=3: size(input2, 2) - 2
        smoothed(i, j, :) = getOrder9Value(input2, i, j);
    endfor
endfor

figure(3);
imshow(smoothed);

% ---------------------------------- questao 4

function pixel = getFilteredPixel(im, i, j, filterMatrix)
    pixel = (
        filterMatrix(1, 1) * im(i - 1, j - 1) +
        filterMatrix(1, 2) * im(i - 1, j) +
        filterMatrix(1, 3) * im(i - 1, j + 1) +
        filterMatrix(2, 1) * im(i, j - 1) +
        filterMatrix(2, 2) * im(i, j) +
        filterMatrix(2, 3) * im(i, j + 1) +
        filterMatrix(3, 1) * im(i + 1, j - 1) +
        filterMatrix(3, 2) * im(i + 1, j) +
        filterMatrix(3, 3) * im(i + 1, j + 1)
    );
    return;
endfunction

sharp1 = uint8(zeros(size(smoothed, 1), size(smoothed, 2)));
sharp2 = sharp1;

for i = 2: size(sharp1, 1) - 1
    for j = 2: size(sharp1, 2) - 1
        prewit1 = [
             1  0 -1;
             1  0 -1;
             1  0 -1;
        ];
        prewit2 = [
            -1  0  1;
            -1  0  1;
            -1  0  1;
        ];
        sharp1(i, j) = getFilteredPixel(smoothed, i, j, prewit1);
        sharp2(i, j) = getFilteredPixel(smoothed, i, j, prewit2);
    endfor
endfor

figure(4);
imshow(sharp1);
figure(5);
imshow(sharp2);


% figure(6);
% imshow(smoothed + sharp1 + sharp2);


# uso isso pois não uso o Octave(GUI) e quando executo pelo terminal
% as janelas com as imagens fecham sozinhas sem isso
while (waitforbuttonpress () == 0) pause(1) end
