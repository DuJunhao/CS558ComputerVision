function combinedGradient=GetGradient(ims,x,y)

z5=ims(x,y,:);
z1=ims(x-1,y+1,:);
z2=ims(x,y+1,:);
z3=ims(x+1,y+1,:);
z4=ims(x-1,y,:);
z6=ims(x+1,y,:);
z7=ims(x-1,y-1,:);
z8=ims(x,y-1,:);
z9=ims(x+1,y-1,:);
Rgradient=sqrt((z6(:,:,1)-z4(:,:,1))^2)+sqrt((z2(:,:,1)-z8(:,:,1))^2);
Ggradient=sqrt((z6(:,:,2)-z4(:,:,2))^2)+sqrt((z2(:,:,2)-z8(:,:,2))^2);
Bgradient=sqrt((z6(:,:,3)-z4(:,:,3))^2)+sqrt((z2(:,:,3)-z8(:,:,3))^2);
combinedGradient=sqrt(Rgradient^2+Ggradient^2+Bgradient^2);
