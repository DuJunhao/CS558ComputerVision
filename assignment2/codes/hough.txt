function [newIms,allM]=houghDetect(ims,points)
[x,y]=size(ims);
[soloPoint,numbers]=size(points);

newIms=zeros(x,y);
allM=[];
for i=1:numbers
    for j=1:soloPoint
        allM=[allM points(j,i)];
    end
end

for i=1:numbers
    row=allM(i*2-1);
    col=allM(i*2);
   newIms(col,row)=1;
end



rho_max=floor(sqrt(x^2+y^2))+1;%the maximum for the parameter space
accumulator =zeros(rho_max,180); %Initialize accumulator 

Theta=[0:pi/180:pi]; %define the theta matrix
for n=1:x
    for m=1:y
        if newIms(n,m)==1
        for k=1:180
        %get ? from the equation
        rho=(m*cos(Theta(k)))+(n*sin(Theta(k)));
        %avoid some negatives
        rho_int=round(rho/2+rho_max/2);
        %accumulate
        accumulator (rho_int,k)=accumulator (rho_int,k)+1;
        end
        end
    end
end

accumulator =uint8(accumulator ); %will lose some data
figure(3)
subplot(1,2,1);imshow(accumulator );title('hough transformation');
hold on;
[rowLine1,colLine1]=find(accumulator==max(max(accumulator)));
line1=accumulator(rowLine1,colLine1);
accumulator(rowLine1,colLine1)=0;

[rowLine2,colLine2]=find(accumulator==max(max(accumulator)));
line2=accumulator(rowLine2,colLine2);
accumulator(rowLine2,colLine2)=0;

[rowLine3,colLine3]=find(accumulator==max(max(accumulator)));
line3=accumulator(rowLine3,colLine3);
accumulator(rowLine3,colLine3)=0;

[rowLine4,colLine4]=find(accumulator==max(max(accumulator)));
line4=accumulator(rowLine4,colLine4);
accumulator(rowLine4,colLine4)=0;

newAccumulator=zeros(rho_max,180);
newAccumulator(rowLine1,colLine1)=line1;
newAccumulator(rowLine2,colLine2)=line2;
newAccumulator(rowLine3,colLine3)=line3;
newAccumulator(rowLine4,colLine4)=line4;

subplot(1,2,2);imshow(newAccumulator );title('hough transformation2');
K=1; %???????
for rho_n=1:rho_max %?hough?????????
    for theta_m=1:180
    if newAccumulator(rho_n,theta_m)>=0 %?????????
    case_accarray_n(K)=rho_n; %??????????
    case_accarray_m(K)=theta_m;
    K=K+1;
    end
    end
end
I_out=zeros(x,y);

for n=1:x
    for m=1:y
    if newIms(n,m)==1
        for k=1:180
        rho=(m*cos(Theta(k)))+(n*sin(Theta(k)));
        rho_int=round(rho/2+rho_max/2);
            for a=1:K-1
            if rho_int==case_accarray_n(a)&k==case_accarray_m(a)%%%==gai==%%% k==case_accarray_m(a)&rho_int==case_accarray_n(a)
            I_out(n,m)=newIms(n,m); 
            end
            end
        end
    end
    end
end
figure(4);imshow(I_out);title('extract the points after hough transformation');
