clear all
close all

pkg load image

origi = uint8(imread('../imgs/4x4.jpg'));

figure(1);
imshow(origi);

rowCount = size(origi, 1);
columnCount = size(origi, 2);

nova = uint8(zeros(rowCount * 2, columnCount * 2, 3));

bigI=1;
for i=1:rowCount
    bigJ=1;
    for j=1:columnCount
        nova(bigI,bigJ,:) = origi(i,j,:);
        bigJ=bigJ+2;
    end
    bigI=bigI+2;
end

figure(2);
imshow(nova);

% TODO: fazer o resto do algoritmo rsrsrsrs

# uso isso pois não uso o Octave - GUI e quando rodo por linha
# de comando a janela fecha sozinha sem isso
while (waitforbuttonpress () == 0) pause(1) end
