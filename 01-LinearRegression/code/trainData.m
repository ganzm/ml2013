%
% Input:
%      X        = m x n feature matrix
%      Y        = m x 1 vector representing the measured result
%      k        = a hyper parameter
function [ w, err ] = trainData( X, Y, k)

    [numSamples, numFeatures] = size(X);
    
    % Closed form solution for Linear Regression
    %w = inv((X' * X)) * X'*Y;
    
    % Closed form solution for Ridge Regression
    w = inv(X'*X + k*eye(numFeatures)) * X'*Y;
    
    % RMSE (Root Mean Square Error)
    sse = sum((Y - (w'*X')').^2); % sum square error
    rmse = sqrt(sse / numSamples); % root mean square error
    cvrmse = rmse / mean(Y);    % CV(RMSE)
    err = cvrmse;
end

