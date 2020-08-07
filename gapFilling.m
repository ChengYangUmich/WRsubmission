function pred_y = gapFilling(y,History,k)
% This function is designed to fill in large nan gap based on History SVD
% result 
%%%%%%%
% '''input''',  y       - an column-vector with nans element,whose length is samller than n  
%               History - an 'm by n' Maxtrix of history observations
%                       - rows are observations 
%                       - columns are features(timestamps) 
%               k       - k-th order approxiamation 
% '''Output''', pred_y  - an 'n by 1' column-vector with nans restored. 

% SVD for the history data 
[~,~,V] =svd(History,'econ');

% prepare the datastreaming input 
blank = nan(size(History,2),1); % create a variable to store streaming data

input = y;
blank(1:length(input)) = input; % update 'blank' with 'y', please notice that the nan in blank comes 
                                % from two source, one is uncollected data
                                % in stream, and the other is nan in 'y' 

bool = ~isnan(blank);  % get the boolean index in 'blank'
% re-order the boolean, and generate the permutation matrix 
[~, I] = sort(bool,'descend');  % I is the index information of permutation 
P = eye(length(blank));
P = P (I,:);                    % Create the permutation matrix 
blank_p = blank(I);             % reorder 'blank' based on permutation 

% Using Ax = b formula to restore unknowns of y
A = P*V;                        % permutate original bases

num_nonnan = sum(~isnan(blank_p));
% divide A and y into two blocks - known vs unknow  
y1 = blank_p(1:num_nonnan);
A1 = A(1:num_nonnan,1:k);
A2 = A(num_nonnan+1:end,1:k);

% calculate the nan part
y2 = A2*(pinv(A1)*y1);

% concatnate back 
y = [y1;y2];

% restore the order
pred_y = P\y;
end

