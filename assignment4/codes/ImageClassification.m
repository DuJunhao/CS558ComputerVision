%function ImageClassification
folder_path1 = './cs558s18_hw4/ImClass/';

%get the histogram
bins = 8;
train_label = zeros(12,1);
train_data = zeros(12,bins*3);
test_label = zeros(12,1);
test_data = zeros(12,bins*3);
classes_filenames = {'coast', 'forest', 'insidecity'};
count = 1;
k=11;
%get the datasets
for i = 1:4
    for c = 1:length(classes_filenames)
        % get the training data
        im_train = imread([folder_path1 classes_filenames{c} '_train' num2str(i) '.jpg']);
        train_label(count) = c;
        train_data(count,:) = [get_histogram(im_train(:,:,1),bins),get_histogram(im_train(:,:,2),bins),get_histogram(im_train(:,:,3),bins)];
        
        % prepare the testing data
        im_test = imread([folder_path1 classes_filenames{c} '_test' num2str(i) '.jpg']);
        test_label(count) = c;
        test_data(count,:) = [get_histogram(im_test(:,:,1),bins) ,get_histogram(im_test(:,:,2),bins), get_histogram(im_test(:,:,3),bins)];
        count = count + 1;
    end
end

% testing
correct = 0;
%get the 1st nearest using the KNN search
test_data_2=test_data';
train_data_2=train_data';
[~,N_test]=size(test_data_2);
neighborhood=zeros(N_test,k);
for i=1:N_test
    [dists, neighbors] = top_K_neighbors(train_data_2,test_data_2(:,i),1);
    neighborhood(i,:)=neighbors;
end
index=neighborhood(:,1);

%classify and get the accuracy
for i = 1:size(test_data,1)
    if train_label(index(i)) == test_label(i)
        correct = correct + 1;
    end
    disp(['Test image ' num2str(i) ' of class ' num2str(test_label(i)) ' has been assigned to class ' num2str(test_label(index(i)))]);
end
disp(['Accuracy: ' num2str(correct*100/size(test_data,1)) '%'])
