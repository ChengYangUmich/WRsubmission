function x = dhubhin2(s,delta)

x =zeros(length(s),1); 
for i = 1:length(s)
    if s(i)>0 
        x(i) = 0;
    elseif s(i) >= -delta
        x(i) = 1/delta*s(i);
    else
        x(i) = -1;
    end
        
end

end