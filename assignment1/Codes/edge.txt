function [desimg,desimg2]=edgeDetection(sigma1,sigma2,filename)

Initial = imread(filename);    
%**************Convert Image to gray scale************** 
% Get the number of rows and columns, 
% and, most importantly, the number of color channels.
[ori_row, ori_col, numberOfColorChannels] = size(Initial);
if numberOfColorChannels > 1
    % It's a true color RGB image.  We need to convert to gray scale.
    grayImage = rgb2gray(Initial);
else
    % It's already gray scale.  No need to convert.
    grayImage=Initial;
end

%*****************Gaussian Filter here********************
%******************Matlab Gaussian Filter************* 
%sigma1 is from the input
N = 7;            
N_row = 2*N+1;
 
OriImage_noise = imnoise(grayImage,'gaussian'); %??
 
gausFilter = fspecial('gaussian',[N_row N_row],sigma1);      %matlab Gaussian Filter
blur=imfilter(OriImage_noise,gausFilter,'conv');
%***************My original Gaussian Filter*********************
H = [];            
for i=1:N_row
    for j=1:N_row
        fenzi=double((i-N-1)^2+(j-N-1)^2);
        H(i,j)=exp(-fenzi/(2*sigma1*sigma1))/(2*pi*(sigma1^2));
    end
end
H=H/sum(H(:));              

H2 = [];            
for i=1:N_row
    for j=1:N_row
        fenzi=double((i-N-1)^2+(j-N-1)^2);
        H2(i,j)=exp(-fenzi/(2*sigma2*sigma2))/(2*pi*sigma2);
    end
end
H2=H2/sum(H2(:)); 

desimg=zeros(ori_row,ori_col);            %images after filter
desimg2=zeros(ori_row,ori_col);
midimg=zeros(ori_row+2*N,ori_col+2*N);    
for i=1:ori_row                           
    for j=1:ori_col
        midimg(i+N,j+N)=OriImage_noise(i,j);
    end
end

temp=[];
for ai=N+1:ori_row+N
    for aj=N+1:ori_col+N
        temp_row=ai-N;
        temp_col=aj-N;
        temp=0;
        for bi=1:N_row
            for bj=1:N_row
                temp= temp+(midimg(temp_row+bi-1,temp_col+bj-1)*H(bi,bj));
            end
        end
        desimg(temp_row,temp_col)=temp;
    end
end
desimg=uint8(desimg);

temp2=[];
for ai=N+1:ori_row+N
    for aj=N+1:ori_col+N
        temp_row=ai-N;
        temp_col=aj-N;
        temp2=0;
        for bi=1:N_row
            for bj=1:N_row
                temp2= temp2+(midimg(temp_row+bi-1,temp_col+bj-1)*H2(bi,bj));
            end
        end
        desimg2(temp_row,temp_col)=temp2;
    end
end
desimg2=uint8(desimg2);

figure(1);
subplot(3,2,1);imshow(Initial);title('Original Piture');
subplot(3,2,2);imshow(OriImage_noise);title('Noisy Picture');
subplot(3,2,3);imshow(desimg);title('my Gaussian Filter with sigma1');
subplot(3,2,4);imshow(desimg2);title('my Gaussian Filter with sigma2');
subplot(3,2,5);imshow(blur);title('matlab Gaussian Filter with sigma1');

%*************Gradient Computation here***************


%design the sobel model
hx = [-1 -2 -1;0 0 0 ;1 2 1];%vertical gradient model of sobel 
hy = hx';                    %horizontal gradient model of sobel

%vertical Gradient
gradx = filter2(hx,desimg,'same');
gradx = abs(gradx); %compute the vertical gradient
%horizontal Gradient
grady = filter2(hy,desimg,'same');
grady = abs(grady); %compute the horizontal gradient
%sobel
grad = gradx + grady;  %get the gradient of the image

gradx2 = filter2(hx,desimg2,'same');
gradx2 = abs(gradx2);
grady2 = filter2(hy,desimg2,'same');
grady2 = abs(grady2);
grad2 = gradx2 + grady2;
% show
figure(2);
subplot(3,2,1);imshow(desimg);title('Original Picture');
subplot(3,2,2);imshow(gradx,[]);title('vertical gradient of sobel ');
subplot(3,2,3);imshow(grady,[]);title('horizontal gradient of sobel');
subplot(3,2,4);imshow(grad,[]);title('gradient of sobel with sigma1');
subplot(3,2,5);imshow(grad2,[]);title('gradient of sobel with sigma2');
%************Perform non-maximum suppression************





