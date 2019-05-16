close all; 
clear all;
clc
prompt1='Please input the first sigma\n';

a=input(prompt1)

prompt2='Please input the second sigma\n';

b=input(prompt2)

prompt3='Please input the fileName, Remember that you should add the quotes to the fileName\n';

c=input(prompt3)

[desimg,desimg2]=edgeDetection(a,b,c);
[m theta sector canny1  canny11 bin] = canny1step(desimg, 17);
[m2 theta2 sector2 canny2  canny22 bin2] = canny1step(desimg2, 8);
 figure(3) 
 subplot(4,2,1);imshow(desimg);title('gradient of sobel with sigma1');
 subplot(4,2,2);imshow(uint8(canny1));title('non maximum suppression with sigma1');
  subplot(4,2,3);imshow(uint8(canny11));title('2 thresholding with sigma1');
  subplot(4,2,4);imshow(bin);title('my final answer bin ');
  subplot(4,2,5);imshow(desimg2);title('gradient of sobel with sigma2');
  subplot(4,2,6);imshow(uint8(canny2));title('non maximum suppression with sigma2 ');
  subplot(4,2,7);imshow(uint8(canny22));title('2 thresholding with sigma2');
  subplot(4,2,8);imshow(bin2);title('my final answer bin2 ');