function m = islocalmax(x,dim)
m  = (circshift(x,1,dim) < x) & (circshift(x,-1,dim) < x) ; %get local maximum point
 
