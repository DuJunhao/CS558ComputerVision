
Initial=imread('wt_slic.png');
[l, Am, Sp, d]=SLIC(Initial,450,10,0,'mean');
 figure(1)
 imshow(l);