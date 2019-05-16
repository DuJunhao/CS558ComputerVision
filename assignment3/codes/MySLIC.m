clc
clear
%READ IMAGE and Pre-Processing
Initial = imread('wt_slic.png');%read image
%cform = makecform('srgb2lab');%RGB to LAB
%lab_Initial = applycform(Initial,cform);%
lab_Initial=double(Initial);
%Initialization
color=[0,0,0];
thre=0.02;%the thresholding to get the segmentation
m=40;%value
k=150;%we need 150 blocks because 500*750/(50*50)=150
Max_Iteration=20;%Max Iteration
x=size(Initial);s=(x(1)*x(2)/k)^0.5;s=ceil(s);%get the length of the ceil=50
row_number=ceil(x(1)/s);%how many blocks in row
col_number=ceil(x(2)/s);%how many blocks in column
ct=row_number*col_number;
belong=ones(x(1),x(2));
center=zeros(ct,5);
%test=zeros(ct,1);
%compute the distance
dist=9999*ones(x(1),x(2));
%first centroid
for test1=1:row_number
    for test2=1:col_number
        if (i<row_number)
            x1=(test1-1)*s+fix(s/2);
        else
            x1=(test1-1)*s+fix(rem(x(1),s)/2);
        end
        if (j<col_number)
            y1=(test2-1)*s+fix(s/2);
        else
            y1=(test2-1)*s+fix(rem(x(2),s)/2);
        end
        %z=lab_Initial(x1,y1,:);
        localCentroid=localShift(lab_Initial,x1,y1);
        xindex=localCentroid{1,1}(1,1);
        yindex=localCentroid{1,2}(1,1);
        z=lab_Initial(xindex,yindex,:);
        center((test1-1)*col_number+test2,:)=[z(:,:,1) z(:,:,2) z(:,:,3) xindex yindex];%Initialize the center
    end
end

%Iteration
t1=clock;
move=99999;
for c=1:Max_Iteration    %iterate for 3 times
    if move<10
        break;
    end
    move=0;
    c1=zeros(ct,1);
    ct_x=zeros(ct,1);
    ct_y=zeros(ct,1);
    ct_l=zeros(ct,1);
    ct_a=zeros(ct,1);
    ct_b=zeros(ct,1);
    %local shift
for i=1:row_number
    for j=1:col_number
        if (i<row_number)
            x1=(i-1)*s+fix(s/2);
        else
            x1=(i-1)*s+fix(rem(x(1),s)/2);
        end
        if (j<col_number)
            y1=(j-1)*s+fix(s/2);
        else
            y1=(j-1)*s+fix(rem(x(2),s)/2);
        end
        %z=lab_Initial(x1,y1,:);
        localCentroid=localShift(lab_Initial,x1,y1);
        xindex=localCentroid{1,1}(1,1);
        yindex=localCentroid{1,2}(1,1);
        z=lab_Initial(xindex,yindex,:);
        center((i-1)*col_number+j,:)=[z(:,:,1) z(:,:,2) z(:,:,3) xindex yindex];
    end
end
        
        
    for i=1:ct
        for u=center(i,4)-s:center(i,4)+s
            if(u>=1)&&(u<=x(1))
                for v=center(i,5)-s:center(i,5)+s   %we search the pixels among 2S*2S blocks
                    if(v>=1)&&(v<=x(2))
                        dc=((lab_Initial(u,v,1)-center(i,1))^2+(lab_Initial(u,v,2)-center(i,2))^2+(lab_Initial(u,v,3)-center(i,3))^2)^0.5;
                        ds=((u-center(i,4))^2+(v-center(i,5))^2)^0.5;
                        d=((dc)^2+(ds*m/s)^2)^0.5;
                        %this equation works very bad.
                        %d=((lab_Initial(u,v,1)-center(i,1))^2+(lab_Initial(u,v,2)-center(i,2))^2+(lab_Initial(u,v,3)-center(i,3))^2+(u/2-center(i,4)/2)^2+(v/2-center(i,5)/2)^2)^0.5;
                        if d<dist(u,v)
                            dist(u,v)=d;
                            belong(u,v)=i; %store the info about which block this pixel belongs to
                            move=move+1;
                        end
                    end
                end
            end
        end
    end
    for row=1:x(1)
        for column=1:x(2)
            i=belong(row,column);
            c1(i)=c1(i)+1;
            ct_x(i)=ct_x(i)+row;
            ct_y(i)=ct_y(i)+column;
            ct_l(i)=ct_l(i)+lab_Initial(row,column,1);
            ct_a(i)=ct_a(i)+lab_Initial(row,column,2);
            ct_b(i)=ct_b(i)+lab_Initial(row,column,3);
            
        end
    end
    for i=1:ct
        center(i,4)=fix(ct_x(i)/c1(i));
        center(i,5)=fix(ct_y(i)/c1(i));
        center(i,1)=fix(ct_l(i)/c1(i));
        center(i,2)=fix(ct_a(i)/c1(i));
        center(i,3)=fix(ct_b(i)/c1(i));
    end
end
t2=clock;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%remove the bad points%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:ct
    bw=zeros(x(1),x(2));
    for k=1:x(1)
        for g=1:x(2)
            if belong(k,g)==i
                bw(k,g)=1;
            end
        end
    end
    [L, num] = bwlabel(bw, 4);%find connected points
    for k=1:num
        [rr, cc] = find(L==k);
        c1=size(rr);
        if c1(1)>0&&c1(1)<100
            for g=1:c1(1)
                if rr(1)-1>=1
                    belong(rr(g),cc(g))=belong(rr(1)-1,cc(1));
                elseif cc(1)-1>=1
                    belong(rr(g),cc(g))=belong(rr(1),cc(1)-1);
                elseif cc(1)+1<=x(2)
                    belong(rr(g),cc(g))=belong(rr(1),cc(1)+1);
                elseif rr(1)+1<=x(1)
                    belong(rr(g),cc(g))=belong(rr(1)+1,cc(1));
                end
            end
        end
    end
end
%get the image after clustered from LAB
Clustered=uint8(lab_Initial);
%cform = makecform('lab2srgb');%from lab to RGB
%Clustered = applycform(Clustered,cform);
Clustered=double(Clustered);
%Clustered=255+zeros(x(1),x(2),3);

%add the edge to every block
for i=1:x(1)
    for j=1:x(2)
        b=0;
        if ((i-1)>=1)&&((j-1)>=1)
            if belong(i-1,j-1)~=belong(i,j)
                Clustered(i,j,1)=color(1);
                Clustered(i,j,2)=color(2);
                Clustered(i,j,3)=color(3);
                b=1;
            end
            if belong(i-1,j)~=belong(i,j)
                Clustered(i,j,1)=color(1);
                Clustered(i,j,2)=color(2);
                Clustered(i,j,3)=color(3);
                b=1;
            end
            if belong(i,j-1)~=belong(i,j)
                Clustered(i,j,1)=color(1);
                Clustered(i,j,2)=color(2);
                Clustered(i,j,3)=color(3);
                b=1;
            end
        elseif ((i-1)>=1)&&((j+1)<=x(2))
            if belong(i-1,j+1)~=belong(i,j)
                Clustered(i,j,1)=color(1);
                Clustered(i,j,2)=color(2);
                Clustered(i,j,3)=color(3);
                b=1;
            end
            if belong(i,j+1)~=belong(i,j)
                Clustered(i,j,1)=color(1);
                Clustered(i,j,2)=color(2);
                Clustered(i,j,3)=color(3);
                b=1;
            end
        elseif ((i+1)<=x(1))&&((j-1)>=1)
            if belong(i+1,j-1)~=belong(i,j)
                Clustered(i,j,1)=color(1);
                Clustered(i,j,2)=color(2);
                Clustered(i,j,3)=color(3);
                b=1;
            end
            if belong(i+1,j)~=belong(i,j)
                Clustered(i,j,1)=color(1);
                Clustered(i,j,2)=color(2);
                Clustered(i,j,3)=color(3);
                b=1;
            end
        elseif ((i+1)<=x(1))&&((j+1)<=x(2))
            if belong(i+1,j+1)~=belong(i,j)
                Clustered(i,j,1)=color(1);
                Clustered(i,j,2)=color(2);
                Clustered(i,j,3)=color(3);
                b=1;
            end
        end
        %if(b==1)&&((i-1)>=1)&&((j-1)>=1)&&((i+1)<=x(1))&&((j+1)<=x(2))
        %    Clustered(i,j+1,1)=color(1);
        %    Clustered(i,j+1,2)=color(2);
        %    Clustered(i,j+1,3)=color(3);
        %    Clustered(i+1,j,1)=color(1);
        %    Clustered(i+1,j,2)=color(2);
        %    Clustered(i+1,j,3)=color(3);
        %end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%show the image%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Clustered=uint8(Clustered);
figure(1)
imshow(Initial), title('Original Image');
figure(20)
imshow(Clustered), title('SLIC with k=150 and m=40')
etime(t2,t1)