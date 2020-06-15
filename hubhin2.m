function x = hubhin2(s,delta)

x =zeros(length(s),1); 
for i = 1:length(s)
    
    if s(i)>0 
        x(i) = 0;
    elseif s(i) >= -delta
        x(i) = 1/(2*delta)*s(i)^2;
    else
        x(i) = -s(i) - delta/2;
    end

end