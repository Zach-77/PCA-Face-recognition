close all;clear all;clc;
G=imread('jpg平均脸1.jpg');
%test=imread('添加颜色.jpg');
I=rgb2gray(G);
%imwrite(I,'average1.jpg');
J24=histeq(I,24);  %直方图均衡化，这一个函数就可以做到均衡化的效果
J48=histeq(I,48); 
J72=histeq(I,72);
%imwrite(J,'after.jpg');
B=im2bw(G);
figure,
subplot(2,2,1),imshow(uint8(I));
title('Original gray image','fontsize',20)
subplot(2,2,2),imshow(uint8(J24));
title('24 equalization','fontsize',20)
subplot(2,2,3),imshow(uint8(J48));
title('48 equalization','fontsize',20)
subplot(2,2,4),imshow(uint8(J72));
title('72 equalization','fontsize',20)

figure,
subplot(1,2,1),imhist(I,32);
title('Original image histogram','fontsize',20);
subplot(1,2,2),imhist(J24,32);
title('after equalization','fontsize',20);
figure;
imshow(B);


