function m = islocalmin(x,dim)
m = (circshift(x,1,dim) > x) & (circshift(x,-1,dim) > x) ;  %get local mimimum point
