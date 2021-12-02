img1 = imread('keble1.png');
img2 = imread('keble2.png');
img1 = imread('uttower1.jpeg');
img2 = imread('uttower2.jpeg');
imshow(img2)

% keble1
PA = [165, 78; 154, 186; 327, 106; 354, 170; 340, 14; 271, 43];
% keble2
PB = [68, 88; 55, 198; 229, 123; 252, 186; 243, 34; 177, 57];

% uttower1
PA = [481, 310; 328, 510; 106, 507; 108, 619; 56, 176; 129, 483; 526, 537; 375, 293];
% % uttower2
PB = [928, 331; 782, 540; 569, 545; 578, 652; 505, 232; 585, 519; 998, 567; 816, 322];

H = estimate_homography(PA, PB);

figure;
imshow(img2);
impixelinfo
pixCoordinate = [165,75];
p1 = pixCoordinate;
p2 = apply_homography(p1, H);
figure;
subplot(1,2,1);

imshow(img1);
hold on;
plot(165,75,'g+', 'MarkerSize', 20, 'LineWidth', 2);
hold off;
subplot(1,2,2);
imshow(img2);
hold on;
plot(p2(1),p2(2), 'y+', 'MarkerSize', 20, 'LineWidth', 2);
hold off;

c = size(img2,1);
figure;
canvas = zeros(size(img2,1) *3, size(img2,2)*3, 3);
canvas = im2uint8(canvas);
stRow = size(img2,1): (size(img2,1)*2)-1;
stCol = size(img2,2): (size(img2,2)*2)-1;

canvas(stRow, stCol,1) = img2(:,:,1);
canvas(stRow, stCol,2) = img2(:,:,2);
canvas(stRow, stCol,3) = img2(:,:,3);

imshow(canvas);
hold on;
for i = 1:size(PA,1)
    p1 = PA(i,:);
    p2 = apply_homography(p1,H);
    plot(p2(1)+size(img2,2),p2(2)+size(img2,1), 'g+', 'MarkerSize', 20, 'LineWidth', 2);
end
hold off;


imshow(canvas);
hold on;
for i = 1:size(img1,2)
    for j =1:size(img1,1)
        p1 = [i,j];
        p2 = apply_homography(p1,H);
        %canvas(p2(1)+size(img2,2),p2(2)+size(img2,1),1) = img1(i,j,1);
        %canvas(p2(1)+size(img2,2),p2(2)+size(img2,1),2) = img1(i,j,2);
        %canvas(p2(1)+size(img2,2),p2(2)+size(img2,1),3) = img1(i,j,3);
        plot(p2(1)+size(img2,2),p2(2)+size(img2,1), 'g+');
    end
    
end
hold off
%imshow(canvas);
%plot(p2(1)+361,p2(2)+265, 'y+', 'MarkerSize', 20, 'LineWidth', 2);











