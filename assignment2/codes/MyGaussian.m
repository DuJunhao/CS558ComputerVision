function desimg=MyGaussian(sigma1)
Initial = imread('road.png');    
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
        H(i,j)=exp(-fenzi/(2*sigma1*sigma1))/(2*pi*sigma1*sigma1);
    end
end
H=H/sum(H(:));              

desimg=zeros(ori_row,ori_col);            %images after filter

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


figure(1);
subplot(2,2,1);imshow(Initial);title('Original Piture');
subplot(2,2,2);imshow(OriImage_noise);title('Noisy Picture');
subplot(2,2,3);imshow(blur);title('matlab Gaussian Filter with sigma1');
subplot(2,2,4);imshow(desimg);title('my Gaussian Filter with sigma1');
