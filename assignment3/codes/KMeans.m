
RGB= imread ('white-tower.png'); 
[m n]=size(RGB);   
figure(1),imshow(RGB);title('Original Image')
hold off;
RGB=double(RGB); 
% filter=ones(5,5);
% filter=filter/sum(filter(:));
% denoised_r=conv2(RGB(:,:,1),filter,'same');
% denoised_g=conv2(RGB(:,:,2),filter,'same');
% denoised_b=conv2(RGB(:,:,3),filter,'same');
% denoised_rgb=cat(3, denoised_r, denoised_g, denoised_b);
% RGB=uint8(denoised_rgb);
% figure(2);imshow(RGB);title('Denoised Image');%after denoise
% RGB=double(RGB);
img1= RGB(:,:,1);
img2=RGB (:,:,2);
img3= RGB (:,:,3);
t=0;

random=floor(rand(3,10)*200+1);%pick 10 clusters
cluster1=zeros(3,21);
cluster1(:,1)=random(:,1);
cluster2=zeros(3,21);
cluster2(:,1)=random(:,2);
cluster3=zeros(3,21);
cluster3(:,1)=random(:,3);
cluster4=zeros(3,21);
cluster4(:,1)=random(:,4);
cluster5=zeros(3,21);
cluster5(:,1)=random(:,5);
cluster6=zeros(3,21);
cluster6(:,1)=random(:,6);
cluster7=zeros(3,21);
cluster7(:,1)=random(:,7);
cluster8=zeros(3,21);
cluster8(:,1)=random(:,8);
cluster9=zeros(3,21);
cluster9(:,1)=random(:,9);
cluster10=zeros(3,21);
cluster10(:,1)=random(:,10);


cluster_idx=zeros(720,1280);
class1_num=0;
class2_num=0;
class3_num=0;
class4_num=0; 
class5_num=0;
class6_num=0;
class7_num=0;
class8_num=0; 
class9_num=0;
class10_num=0;
cluster_number=zeros(10);

sum=zeros(3,10);
for k=1:20
    if t==0
       for i=1:720
            for j=1:1280
                DistanceCluster1=sqrt((img1(i,j)-cluster1(1,k))^2+(img2(i,j)-cluster1(2,k))^2+(img3(i,j)-cluster1(3,k))^2);
                DistanceCluster2=sqrt((img1(i,j)-cluster2(1,k))^2+(img2(i,j)-cluster2(2,k))^2+(img3(i,j)-cluster2(3,k))^2);
                DistanceCluster3=sqrt((img1(i,j)-cluster3(1,k))^2+(img2(i,j)-cluster3(2,k))^2+(img3(i,j)-cluster3(3,k))^2);
                DistanceCluster4=sqrt((img1(i,j)-cluster4(1,k))^2+(img2(i,j)-cluster4(2,k))^2+(img3(i,j)-cluster4(3,k))^2); 
                DistanceCluster5=sqrt((img1(i,j)-cluster5(1,k))^2+(img2(i,j)-cluster5(2,k))^2+(img3(i,j)-cluster5(3,k))^2); 
                DistanceCluster6=sqrt((img1(i,j)-cluster6(1,k))^2+(img2(i,j)-cluster6(2,k))^2+(img3(i,j)-cluster6(3,k))^2); 
                DistanceCluster7=sqrt((img1(i,j)-cluster7(1,k))^2+(img2(i,j)-cluster7(2,k))^2+(img3(i,j)-cluster7(3,k))^2); 
                DistanceCluster8=sqrt((img1(i,j)-cluster8(1,k))^2+(img2(i,j)-cluster8(2,k))^2+(img3(i,j)-cluster8(3,k))^2); 
                DistanceCluster9=sqrt((img1(i,j)-cluster9(1,k))^2+(img2(i,j)-cluster9(2,k))^2+(img3(i,j)-cluster9(3,k))^2); 
                DistanceCluster10=sqrt((img1(i,j)-cluster10(1,k))^2+(img2(i,j)-cluster10(2,k))^2+(img3(i,j)-cluster10(3,k))^2);         
                %compute the distance from every pixels to the cluster points 
                Z=[DistanceCluster1,DistanceCluster2,DistanceCluster3,DistanceCluster4,DistanceCluster5,DistanceCluster6,DistanceCluster7,DistanceCluster8,DistanceCluster9,DistanceCluster10];
                %disp(DistanceCluster2);
                %Z=[DistanceCluster1,DistanceCluster2,DistanceCluster3,DistanceCluster4];
                d=min(Z);
                if d==DistanceCluster1
                   class1_num=class1_num+1;
                   cluster_number(1)=cluster_number(1)+1;
                   cluster_idx(i,j)=1;
                   sum(:,1)=sum(:,1)+[img1(i,j) ;img2(i,j) ;img3(i,j)];
                end
                if d==DistanceCluster2
                   class2_num=class2_num+1;
                   cluster_idx(i,j)=2;
                   sum(:,2)=sum(:,2)+[img1(i,j);img2(i,j);img3(i,j)];
                end
                if d==DistanceCluster3
                   class3_num=class3_num+1;
                   cluster_idx(i,j)=3;
                   sum(:,3)=sum(:,3)+[img1(i,j); img2(i,j); img3(i,j)];
                end
                if d==DistanceCluster4
                   class4_num=class4_num+1;
                   cluster_idx(i,j)=4;
                   sum(:,4)=sum(:,4)+[img1(i,j); img2(i,j); img3(i,j)];
                end
                
                 if d==DistanceCluster5
                   class5_num=class5_num+1;
                   cluster_idx(i,j)=5;
                   sum(:,5)=sum(:,5)+[img1(i,j); img2(i,j); img3(i,j)];
                 end
                if d==DistanceCluster6
                   class6_num=class6_num+1;
                   cluster_idx(i,j)=6;
                   sum(:,6)=sum(:,6)+[img1(i,j); img2(i,j); img3(i,j)];
                end
                if d==DistanceCluster7
                   class7_num=class7_num+1;
                   cluster_idx(i,j)=7;
                   sum(:,7)=sum(:,7)+[img1(i,j); img2(i,j); img3(i,j)];
                end
                if d==DistanceCluster8
                   class8_num=class8_num+1;
                   cluster_idx(i,j)=8;
                   sum(:,8)=sum(:,8)+[img1(i,j); img2(i,j); img3(i,j)];
                end
                if d==DistanceCluster9
                   class9_num=class9_num+1;
                   cluster_idx(i,j)=9;
                   sum(:,9)=sum(:,9)+[img1(i,j); img2(i,j); img3(i,j)];
                end
                if d==DistanceCluster10
                   class10_num=class10_num+1;
                   cluster_idx(i,j)=10;
                   sum(:,10)=sum(:,10)+[img1(i,j); img2(i,j); img3(i,j)];
                end
            end
       end
       
       %compute the means  
       cluster1(:,k+1)=sum(:,1)/class1_num;
       cluster2(:,k+1)=sum(:,2)/class2_num;
       cluster3(:,k+1)=sum(:,3)/class3_num;
       cluster4(:,k+1)=sum(:,4)/class4_num;
       cluster5(:,k+1)=sum(:,5)/class5_num;
       cluster6(:,k+1)=sum(:,6)/class6_num;
       cluster7(:,k+1)=sum(:,7)/class7_num;
       cluster8(:,k+1)=sum(:,8)/class8_num;
       cluster9(:,k+1)=sum(:,9)/class9_num;
       cluster10(:,k+1)=sum(:,10)/class10_num;

       
       Dist1=abs(cluster1(:,k+1)-cluster1(:,k));
       Dist2=abs(cluster2(:,k+1)-cluster2(:,k));
       Dist3=abs(cluster3(:,k+1)-cluster3(:,k));
       Dist4=abs(cluster4(:,k+1)-cluster4(:,k));
       Dist5=abs(cluster5(:,k+1)-cluster5(:,k));
       Dist6=abs(cluster6(:,k+1)-cluster6(:,k));
       Dist7=abs(cluster7(:,k+1)-cluster7(:,k));
       Dist8=abs(cluster8(:,k+1)-cluster8(:,k));
       Dist9=abs(cluster9(:,k+1)-cluster9(:,k));
       Dist10=abs(cluster10(:,k+1)-cluster10(:,k));

       if(Dist1(1,1)<0.001 && Dist1(2,1)<0.001&&Dist1(3,1)<0.001 && Dist2(1,1)<0.001 &&Dist3(2,1)<0.001&&Dist2(3,1)<0.001&&Dist3(1,1)<0.001&&Dist3(2,1)<0.001&&Dist3(3,1)<0.001&& Dist4(1,1)<0.001&&Dist4(2,1)<0.001&&Dist4(3,1)<0.001   &&Dist5(1,1)<0.001&&Dist5(2,1)<0.001&&Dist5(3,1)<0.001 &&Dist6(1,1)<0.001&&Dist6(2,1)<0.001&&Dist6(3,1)<0.001 &&Dist7(1,1)<0.001&&Dist7(2,1)<0.001&&Dist7(3,1)<0.001 &&Dist8(1,1)<0.001&&Dist8(2,1)<0.001&&Dist8(3,1)<0.001 &&Dist9(1,1)<0.001&&Dist9(2,1)<0.001&&Dist9(3,1)<0.001 &&Dist10(1,1)<0.001&&Dist10(2,1)<0.001&&Dist10(3,1)<0.001)
      % if(1==1) 
       t=1;
       end    
    end
end


for i=1:720
    for j=1:1280
        if cluster_idx(i,j)==1
           img1(i,j)=255;
           img2(i,j)=0;
           img3(i,j)=0;
        end
        if cluster_idx(i,j)==2
           img1(i,j)=255;
           img2(i,j)=255;
           img3(i,j)=0;
        end
        if cluster_idx(i,j)==3
           img1(i,j)=0;
           img2(i,j)=0;
           img3(i,j)=255;
        end
        if cluster_idx(i,j)==4
           img1(i,j)=0;
           img2(i,j)=128;
           img3(i,j)=0;
        end
        if cluster_idx(i,j)==5
           img1(i,j)=0;
           img2(i,j)=255;
           img3(i,j)=0;
        end
        if cluster_idx(i,j)==6
           img1(i,j)=0;
           img2(i,j)=255;
           img3(i,j)=255;
        end
        if cluster_idx(i,j)==7
           img1(i,j)=255;
           img2(i,j)=0;
           img3(i,j)=255;
        end
        if cluster_idx(i,j)==8
           img1(i,j)=128;
           img2(i,j)=0;
           img3(i,j)=0;
        end
        if cluster_idx(i,j)==9
           img1(i,j)=0;
           img2(i,j)=0;
           img3(i,j)=128;
        end
        if cluster_idx(i,j)==10
           img1(i,j)=64;
           img2(i,j)=64;
           img3(i,j)=64;
        end
    end
end
Img1=uint8(img1);
Img2=uint8(img2);
Img3=uint8(img3);
R=cat(3,Img1,Img2,Img3);
figure(2),imshow(R);title('after Clustered')