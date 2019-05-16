function [ims,DetectedPoints,points]  = PreProcessing(threshold,sigma)
% HESSIANDET  Basic Hessian detector
%   F = HESSIANDET(IM) runs a basic implementation of the Hessian
%   detector on the gray-scale image IM.   
ims = MyGaussian(sigma) ;

d2 = [1 -2 1];   %filter
d = [-1 0 1]/2 ; %filter
im11 = conv2(1,d2,ims,'same') ; %Dyy
im22 = conv2(d2,1,ims,'same') ; %Dxx
im12 = conv2(d,d,ims,'same') ;  %Dxy
score = im11.*im22 - im12.*im12 ; %det(H)

 
points = (islocalmax(score,1) .* islocalmax(score,2)) + ...
         (islocalmin(score,1) .* islocalmin(score,2)) ;
 
     
 points = points .* (abs(score) >threshold) ;


[i,j] = find(points) ;
DetectedPoints=[j(:),i(:)]';

%DetectedPoints=find(DetectedPoints>3 &&DetectedPoints<544);
[m, n]=size(DetectedPoints);
H=[m,n];
i=1;
j=1;
%remove the margin of the image
while i<=m
   while j<=n 
     if(DetectedPoints(i,j)<5||DetectedPoints(i,j)>542)
       DetectedPoints(:,j)=[];
       n=n-1;
       i=i-1;
       break;
     end
     j=j+1;
   end
   i=i+1;
end
