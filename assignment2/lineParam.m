%----------------------------------------------
%a * x1 + b * y1 + c = 0
%a * x2 + b * y2 + c = 0
%a^2 + b^2 = 1
%return [a b c]
%----------------------------------------------
function line = lineParam(data)
    x = data(1,:);
    y = data(2,:);
    
    k = (y(1) - y(2)) / (x(1) - x(2));%slope, need more judgement, now ignore something
    a = sqrt(1 - 1 / (1 + k^2));
    b = sqrt(1 - a^2);
    
    if k > 0
        b = -b;
    end
    
    c = -a * x(1) - b * y(1);
    line = [a b c];
   % disp(line);
end
 
