function localCentroid=localShift(ims,x,y)
gradient5=GetGradient(ims,x,y);
gradient1=GetGradient(ims,x-1,y+1);
gradient2=GetGradient(ims,x,y+1);
gradient3=GetGradient(ims,x+1,y+1);
gradient4=GetGradient(ims,x-1,y);
gradient6=GetGradient(ims,x+1,y);
gradient7=GetGradient(ims,x-1,y-1);
gradient8=GetGradient(ims,x,y-1);
gradient9=GetGradient(ims,x+1,y-1);
gradientVector=[gradient5,gradient1,gradient2,gradient3,gradient4,gradient6,gradient7,gradient8,gradient9];
k = find(gradientVector == min(gradientVector),1);
%disp(k);
localCentroid={1,1};
if(k==1)
    localCentroid={x,y};
elseif k==2
    localCentroid={x-1,y+1};
elseif k==3
    localCentroid={x,y+1};
elseif k==4
    localCentroid={x+1,y+1};
elseif k==5
    localCentroid={x-1,y};
elseif k==6
    localCentroid={x+1,y};
elseif k==7
    localCentroid={x-1,y-1};
elseif k==8
    localCentroid={x,y-1};
elseif k==9
    localCentroid={x+1,y-1};
end