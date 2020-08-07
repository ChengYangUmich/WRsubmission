function [diurnal,spike,loss] = seperatePattern(signal,fourier_order,w,beta,mu,maxiters,delta)
% Syntax:       [diurnal,spike,loss] = seperatePattern(signal,fourier_order,w,beta,mu,maxiters,delta)
%               
% Inputs:
%     (Mandotory)
%     * `signal` is a vector of length m
%     (Optional)
%     * `fourier_order` is the order of fourier fitting for diuranl pattern
%     * `w` is the frequency of fourier terms to use, by default, it satifies 2*pi*f,where f = 720
%     * `beta` is the penalty coefficient in the non-negative optimizer.
%     * `mu` is the step size to use, and must satisy 0 < mu < 2 / norm(A)^2 to guarantee convergence
%     * `maxiters` is the number of iterations to perform
%               
% Output:
%     * `Diurnal` is a vector of length m,  which represents by the fourier fitting
%     * `spike` is a vector of length m, whic represents the non-negative shooting-ups(leachate) in the raw signals
%     * `loss ` is a vector of length maxiters, which was a output to check if optimizator learns or not
%               
%               
% Description:
%         This function is used to seperate the diurnal patterns and leachate of a one-day signal series(720 points).
%         It is a non-negative least square optimization problem.
%         Nesterov gradient descent is used to solve the non-negative regularized least squares
%         The penalty term is huber-hinger penalty:
%         Assume: y = T * x + s, where T*X is the fourier term and s is the spike term
%                 y = [T I]*[x;s] = Atil*xtil
%         loss = min_x (y - T*x -s) + beta * h(s)
%              = min_x (y - Atil*xtil) + beta*h(C*xtil),where C is a matrix to extract s from x.

%               
% Author:       Cheng Yang
%               yangche@umich.edu
%               
% Date:         1/30/2020
%

% Constants 
MAX_ITERS =  1000;
MU = 0.001;
BETA = 0.5;
W = 2*pi/720;
FOURIER_ORDER = 3; 
HHWINDOW = 10; 

% Parse inputs 
if ~exist('fourier_order','var') || isempty(fourier_order)
    fourier_order= FOURIER_ORDER;
end

if ~exist('w','var') || isempty(w)
    w= W;
end

if ~exist('beta','var') || isempty(beta)
    beta= BETA;
end

if ~exist('mu','var') || isempty(mu)
    mu= MU;
end

if ~exist('maxiters','var') || isempty(maxiters)
    maxiters= MAX_ITERS;
end

if ~exist('delta','var') || isempty(hhwindow)
    delta= HHWINDOW;
end


% Code implementation 
    b = signal(:);
    m = length(b);
    d = fourier_order;
    t = 1:length(b);
    T = zeros(length(b),2*d+1);

    C = diag([zeros(2*d+1,1); ones(m,1)]);

    for  i = 1:d
        
        T(:,2*i) = cos(i*w*t);
        
        T(:,2*i+1) = sin(i*w*t);
    end
    T(:,1) =ones(m,1);

    Atil = [T,eye(m,m)];
    % random initialization
    x0 = randn(size(Atil,2),1);
    x0 = x0/norm(x0);

    [xhh,loss] = hhlsngd(Atil,b, C , beta, delta,  mu, x0, maxiters);

    diurnal = T*xhh(1:2*d+1);
    spike = xhh(2*d+2:end);

end


