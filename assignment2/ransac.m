function [numbers,MaxIteration]=ransac(ims,points,DistanceThresholding,inliersRatio)


nSampLen=2;
Probability=0.99;
MinimumNumber=6;
numbers=size(points,1);%number of points
MaxIteration = log(1-Probability)/log(1-(inliersRatio)^MinimumNumber);   %the times to choose the best line
pretotal = 0; %the number fits the model
k = 1;

RANSAC_model = NaN;                 %??????
RANSAC_mask = zeros([1 numbers]);  %?0???1???????0?????
nMaxInlyerCount = -1;
% ???
for i = 1:MaxIteration
    %  ???????????
    SampleMask = zeros([1 numbers]);  
    while sum( SampleMask ) ~= nSampLen
        ind = ceil(numbers .* rand(1, nSampLen - sum(SampleMask))); %rand??????ceil???????????
        SampleMask(ind) = 1;
    end    
    Sample = find( SampleMask );        %??????????????????
    % ????,?????????
    ModelSet = feval(@TLS, points(:, Sample));    %???????????????
    for iModel = 1:size(ModelSet, 3) 
      CurModel = ModelSet(:, :, iModel);        %???????????   
      CurMask =( abs( CurModel * [points; ones([1 size(points, 2)])])< DistanceThresholding);%???????????????,???1
      nCurInlyerCount = sum(CurMask);           %?????????????
        % ??????
        if nCurInlyerCount > nMaxInlyerCount    %??????????????????
            nMaxInlyerCount = nCurInlyerCount;
            RANSAC_mask = CurMask;
            RANSAC_model = CurModel;
        end
    end
end

    
%show the image
figure(2)

imshow(ims);
hold on;
 plot(points(1,:),points(2,:),'o');
 hold on; 
%show the line by many points

MinX=min(points(1, :));
MaxX=max(points(1, :));
MinX_Y=-(RANSAC_model(1).*MinX+RANSAC_model(3))./RANSAC_model(2);
MaxX_Y=-(RANSAC_model(1).*MaxX+RANSAC_model(3))./RANSAC_model(2);
plot([MinX MaxX],[MinX_Y MaxX_Y],'+');
title('ransac with noise');
