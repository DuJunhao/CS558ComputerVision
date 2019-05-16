function [ m, theta, sector, canny1,  canny2, bin] = canny1step( src,  lowTh)

[Ay Ax dim ] = size(src);
src = double(src);
m = zeros(Ay, Ax); 
theta = zeros(Ay, Ax);
sector = zeros(Ay, Ax);
canny1 = zeros(Ay, Ax);%non maximum suppression
canny2 = zeros(Ay, Ax);%2 thresholding 
bin = zeros(Ay, Ax);

for y = 1:(Ay-1)
    for x = 1:(Ax-1)
        gx =  src(y, x) + src(y+1, x) - src(y, x+1)  - src(y+1, x+1);
        gy = -src(y, x) + src(y+1, x) - src(y, x+1) + src(y+1, x+1);
        m(y,x) = (gx^2+gy^2)^0.5 ;
        %--------------------------------
        theta(y,x) = atand(gx/gy)  ;
        tem = theta(y,x);
        %--------------------------------
        if (tem<67.5)&&(tem>22.5)
            sector(y,x) =  0;    
        elseif (tem<22.5)&&(tem>-22.5)
            sector(y,x) =  3;    
        elseif (tem<-22.5)&&(tem>-67.5)
            sector(y,x) =   2;    
        else
            sector(y,x) =   1;    
        end
        %--------------------------------        
    end    
end
%-------------------------
%non maximum suppression
%------> x
%   2 1 0
%   3 X 3
%y  0 1 2
for y = 2:(Ay-1)
    for x = 2:(Ax-1)        
        if 0 == sector(y,x) %orthogonal 
            if ( m(y,x)>m(y-1,x+1) )&&( m(y,x)>m(y+1,x-1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 1 == sector(y,x) %vertical
            if ( m(y,x)>m(y-1,x) )&&( m(y,x)>m(y+1,x)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 2 == sector(y,x) %orthogonal 
            if ( m(y,x)>m(y-1,x-1) )&&( m(y,x)>m(y+1,x+1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        elseif 3 == sector(y,x) %horizontal
            if ( m(y,x)>m(y,x+1) )&&( m(y,x)>m(y,x-1)  )
                canny1(y,x) = m(y,x);
            else
                canny1(y,x) = 0;
            end
        end        
    end%end for x
end%end for y

%---------------------------------
%2 thresholdings
ratio = 2;
for y = 2:(Ay-1)
    for x = 2:(Ax-1)        
        if canny1(y,x)<lowTh %low thresholding
            canny2(y,x) = 0;
            bin(y,x) = 0;
            continue;
        elseif canny1(y,x)>ratio*lowTh %high thresholding
            canny2(y,x) = canny1(y,x);
            bin(y,x) = 1;
            continue;
        else %between 2 thresholding, it also can be the edge
            tem =[canny1(y-1,x-1), canny1(y-1,x), canny1(y-1,x+1);
                       canny1(y,x-1),    canny1(y,x),   canny1(y,x+1);
                       canny1(y+1,x-1), canny1(y+1,x), canny1(y+1,x+1)];
            temMax = max(tem);
            if temMax(1) > ratio*lowTh
                canny2(y,x) = temMax(1);
                bin(y,x) = 1;
                continue;
            else
                canny2(y,x) = 0;
                bin(y,x) = 0;
                continue;
            end
        end
    end%end for x
end%end for y



end%end of function
