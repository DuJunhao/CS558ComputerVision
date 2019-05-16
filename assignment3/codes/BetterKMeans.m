function FinalCluster=KMeans(RGB,clusterNumbers);
[m n]=size(RGB);
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
[row,col,channel]=size(RGB);
random=floor(rand(3,10)*200+1);%pick 10 clusters
for i=1:clusterNumbers
    cluster{i}=zeros(3,21);
    class_num(i)=0;
    cluster{i}(:,1)=random(:,i);
end

cluster_idx=zeros(row,col);
DistanceCluster=1./zeros(10,1);
sum=zeros(3,10);
IterationSteps=20;
for k=1:IterationSteps
    if t==0
        for i=1:row
            for j=1:col   
                for w=1:10
                    DistanceCluster(w)=sqrt((img1(i,j)-cluster{w}(1,k))^2+(img2(i,j)-cluster{w}(2,k))^2+(img3(i,j)-cluster{w}(3,k))^2);
                end    
               %disp(DistanceCluster(2));
                %compute the distance from every pixels to the cluster points
                %Z=[DistanceCluster1,DistanceCluster2,DistanceCluster3,DistanceCluster4,DistanceCluster5,DistanceCluster6,DistanceCluster7,DistanceCluster8,DistanceCluster9,DistanceCluster10];
                d=find(DistanceCluster==min(DistanceCluster));
                %disp(d);
                d=d(1,1);
                class_num(d)=class_num(d)+1;
                cluster_idx(i,j)=d;
                sum(:,d)=sum(:,d)+[img1(i,j) ;img2(i,j) ;img3(i,j)];
            end
        end
        %compute the means
        for i=1:10
            cluster{i}(:,k+1)=sum(:,i)/class_num(i);
            %disp(sum(:,i)/class_num(i));
        end
        for i=1:10
            Dist{i}=abs(cluster{i}(:,k+1)-cluster{i}(:,k));
            %disp(Dist{i});
        end
        
        flag=zeros(10,1);
        
        for i=1:10
            if(Dist{i}(1,1)<0.001 && Dist{i}(2,1)<0.001&&Dist{i}(3,1)<0.001)
                flag(i)=1;
            end
        end
        ENDINGflag=1;
        for i=1:10
            if(flag(i)==0)
                ENDINGflag=0;
                %disp(ENDINGflag);
            end
        end
        
        if ENDINGflag==1
            t=1;
        end
    end
end

for i=1:clusterNumbers
FinalCluster{i}=cluster{i}(:,IterationSteps);
end