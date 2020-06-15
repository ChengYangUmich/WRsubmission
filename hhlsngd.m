function [x,loss] = hhlsngd(A ,b, C , beta, delta,  mu, x0, maxiters)

loss = zeros(maxiters,1);
t = 0;
xLast = x0;
x = x0;

for idx = 1:maxiters
    % t update
    tLast = t;
    t = (1 + sqrt(1+4*tLast^2))/2;
    
    % z update (momentum)
    z = x + (tLast-1)/t * (x - xLast);
    
    % x update
    xLast = x;
    x = z - mu * (A' * (A * z - b)+ beta*C'*dhubhin2(C*z,delta));
    loss(idx) = norm(A * x - b) + beta * sum(hubhin2(C*x,delta));
end

end

