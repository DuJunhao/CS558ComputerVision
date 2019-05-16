function [columnPoints,inliers]=ransacTest(ims,points,DistanceThresholding,inliersRatio)



Probability=0.99;
MinimumNumber=6;
[rows,columns]=size(points);%number of points
MaxIteration = log(1-Probability)/log(1-(inliersRatio)^MinimumNumber);   %the times to choose the best line
pretotal = 0; %the number fits the model



%%the first line
for i=1:MaxIteration
 % randomly pick 2 points
     randomPoints = randperm(columns,2); 
     sample = points(:,randomPoints); 

     %%%fit the equation y=kx+b
     line = zeros(1,3);
     x1 = sample(:, 1);
     y1 = sample(:, 2);

     k=(y1(1)-y1(2))/(x1(1)-x1(2));      %get the slope
     b = y1(1) - k*x1(1);
     line = [k -1 b];

     mask=abs(line*[points; ones(1,size(points,2))]);    %get the distance from points to line
     total=sum(mask<DistanceThresholding);              %get the number of points which are below the thresholding.

     if total>pretotal            %find the line fits most points
         pretotal=total;
         bestline1=line;          %get the best line to fit the equation
    end  
end


%show the image
 figure(2) 
 imshow(ims); title('This is the picture with ransac detector');
 hold on;
 plot(points(1,:),points(2,:),'o');
 
  %show the line1
mask=abs(bestline1*[points; ones(1,size(points,2))])<DistanceThresholding;  
k=1;
for i=1:length(mask)
    if mask(i)
        inliers(1,k) = points(1,i);
        k=k+1;
        plot(points(1,i),points(2,i),'+');
    end
end

 bestParameter1 = -bestline1(1)/bestline1(2);
 bestParameter2 = -bestline1(3)/bestline1(2);
 xAxis1 = min(inliers(1,:)):max(inliers(1,:));
 yAxis1 = bestParameter1*xAxis1 + bestParameter2;
 plot(xAxis1,yAxis1,'r','LineWidth',2);
 hold on;
 [inlierRow,inlierLength]=size(inliers);
 columnPoints=points;
 columnPoints(2,:)=[];
 for i=1:inlierLength
     index=find(columnPoints==inliers(i));
     columnPoints(:,index)=[];
     points(:,index)=[];
 end
 
 
 
 
 
%%the second line 
pretotal = 0;
[rows,columns]=size(points);
for i=1:MaxIteration
 % randomly pick 2 points
     randomPoints = randperm(columns,2); 
     sample = points(:,randomPoints); 

     %%%fit the equation y=kx+b
     line2 = zeros(1,3);
     x2 = sample(:, 1);
     y2 = sample(:, 2);

     k2=(y2(1)-y2(2))/(x2(1)-x2(2));      %get the slope
     b2 = y2(1) - k2*x2(1);
     line2 = [k2 -1 b2];

     mask2=abs(line2*[points; ones(1,size(points,2))]);    %get the distance from points to line
     total=sum(mask2<DistanceThresholding);              %get the number of points which are below the thresholding.

     if total>pretotal            %find the line fits most points
         pretotal=total;
         bestline2=line2;          %get the best line to fit the equation
    end  
end
  %show the line2
mask2=abs(bestline2*[points; ones(1,size(points,2))])<DistanceThresholding; 
k=1;
for i=1:length(mask2)
    if mask2(i)
        inliers2(1,k) = points(1,i);
        k=k+1;
        plot(points(1,i),points(2,i),'+');
    end
end
hold on;
 bestParameter1 = -bestline2(1)/bestline2(2);
 bestParameter2 = -bestline2(3)/bestline2(2);
 xAxis = min(inliers2(1,:)):max(inliers2(1,:));
 yAxis = bestParameter1*xAxis + bestParameter2;
 plot(xAxis,yAxis,'g','LineWidth',2);
hold on;
 [inlierRow,inlierLength]=size(inliers2);
 for i=1:inlierLength
     index=find(columnPoints==inliers2(i));
     columnPoints(:,index)=[];
     points(:,index)=[];
 end
 
 
 
%%the thrid line 
pretotal = 0;
[rows,columns]=size(points);
for i=1:MaxIteration
 % randomly pick 2 points
     randomPoints = randperm(columns,2); 
     sample = points(:,randomPoints); 

     %%%fit the equation y=kx+b
     line3 = zeros(1,3);
     x3 = sample(:, 1);
     y3 = sample(:, 2);

     k3=(y3(1)-y3(2))/(x3(1)-x3(2));      %get the slope
     b3 = y3(1) - k3*x3(1);
     line3 = [k3 -1 b3];

     mask3=abs(line3*[points; ones(1,size(points,2))]);    %get the distance from points to line
     total=sum(mask3<DistanceThresholding);              %get the number of points which are below the thresholding.

     if total>pretotal            %find the line fits most points
         pretotal=total;
         bestline3=line3;          %get the best line to fit the equation
    end  
end

  %show the line3
mask3=abs(bestline3*[points; ones(1,size(points,2))])<DistanceThresholding; 

k=1;
for i=1:length(mask3)
    if mask3(i)
        inliers3(1,k) = points(1,i);
        k=k+1;
        plot(points(1,i),points(2,i),'+');
    end
end
hold on;

 bestParameter1 = -bestline3(1)/bestline3(2);
 bestParameter2 = -bestline3(3)/bestline3(2);
 xAxis = min(inliers3(1,:)):max(inliers3(1,:));
 yAxis = bestParameter1*xAxis + bestParameter2;
 plot(xAxis,yAxis,'b','LineWidth',2);
 hold on;
 [inlierRow,inlierLength]=size(inliers3);
 for i=1:inlierLength
     index=find(columnPoints==inliers3(i));
     columnPoints(:,index)=[];
     points(:,index)=[];
 end
 
 
 
 
 
 
%%the fourth line 
pretotal = 0;
[rows,columns]=size(points);
for i=1:MaxIteration
 % randomly pick 2 points
     randomPoints = randperm(columns,2); 
     sample = points(:,randomPoints); 

     %%%fit the equation y=kx+b
     line4 = zeros(1,3);
     x4 = sample(:, 1);
     y4 = sample(:, 2);

     k4=(y4(1)-y4(2))/(x4(1)-x4(2));      %get the slope
     b4 = y4(1) - k4*x4(1);
     line4 = [k4 -1 b4];

     mask4=abs(line4*[points; ones(1,size(points,2))]);    %get the distance from points to line
     total=sum(mask4<DistanceThresholding);              %get the number of points which are below the thresholding.

     if total>pretotal            %find the line fits most points
         pretotal=total;
         bestline4=line4;          %get the best line to fit the equation
    end  
end


  %show the line4

mask4=abs(bestline4*[points; ones(1,size(points,2))])<DistanceThresholding; 

k=1;
for i=1:length(mask4)
    if mask4(i)
        inliers4(1,k) = points(1,i);
        k=k+1;
        plot(points(1,i),points(2,i),'+');
    end
end


 bestParameter1 = -bestline4(1)/bestline4(2);
 bestParameter2 = -bestline4(3)/bestline4(2);
 xAxis = min(inliers4(1,:)):max(inliers4(1,:));
 yAxis = bestParameter1*xAxis + bestParameter2;
 plot(xAxis,yAxis,'r-','LineWidth',2);
 
 

