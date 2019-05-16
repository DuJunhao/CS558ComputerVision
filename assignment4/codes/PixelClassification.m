folder_path2 = './cs558s18_hw4/sky/';
train_image = imread([folder_path2 'sky_train.jpg']);
sky_mask = imread([folder_path2 'sky_train_mask.jpg']);
train_image = double(train_image);
sky_mask = double(sky_mask);
[s1,s2,s3] = size(train_image);
sky_color(1,1,1) = 254;
sky_color(1,1,2) = 0;
sky_color(1,1,3) = 0;
skyNumbers = 1;
nonSkyNumbers = 1;
for x = 1:s1
    for y = 1:s2
        if sky_mask(x,y,:) == sky_color
            sky(skyNumbers,:) = train_image(x,y,:);
            skyNumbers = skyNumbers + 1;
        else
            non_sky(nonSkyNumbers,:) = train_image(x,y,:);
            nonSkyNumbers = nonSkyNumbers + 1;
        end
    end
end
k = 10;
[~,skywords] = kmeans(sky, k, 'EmptyAction', 'singleton');
[~,nonskywords] = kmeans(non_sky, k, 'EmptyAction', 'singleton');
% words :: [label r g b]
words = [ones(k,1) skywords; zeros(k,1) nonskywords];

% testing
for tt = 1:4
    test_image = imread([folder_path2 'sky_test' num2str(tt) '.jpg']);
    [s1,s2,s3] = size(test_image);
    test_pixels = double(reshape(test_image,s1*s2,s3,1));
    % search the 1st closest word using Knn
    newW=words(:,2:end)';
    test_pixels_2=test_pixels';
    [~,N_test]=size(test_pixels_2);
    neighborhood=zeros(N_test,k);
    for i=1:N_test
        [dists, neighbors] = top_K_neighbors(newW,test_pixels_2(:,i),k);
        neighborhood(i,:)=neighbors;
    end
    idx=neighborhood(:,1);
    lables = words(idx,1);
    % getting 2D indices for pixel vector
    [xx,yy] = ind2sub([s1 s2],1:s1*s2);
    
    for i = 1:s1*s2
        % if the pixel is classified as sky, label it
        if lables(i) == 1
            test_image(xx(i),yy(i),:) = sky_color;
        end
    end
    figure('Name', ['sky_test' num2str(tt)]);
    imshow(test_image);
end