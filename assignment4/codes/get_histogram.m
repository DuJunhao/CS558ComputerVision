function hist = get_histogram(im, bins)
    [row,col]=size(im);
    binsize = row/bins - 1;
    X = double(im(:));
    
    hist(1) = size(find(X < binsize),1);
    
    for i = 2:bins
       hist(i) = size(find(X < i*binsize),1) - sum(hist(1:i-1));
    end
end