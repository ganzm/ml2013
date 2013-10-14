%
% Input:
%      X        = m x n feature matrix
%      Y        = m x 1 vector representing the measured result
%      h        = a hyper parameter
function [ w, err ] = trainData( X, Y, h)
    [numSamples, numFeatures] = size(X);
    w = zeros(numFeatures, 1);
    err = 0;
    
    % Closed form solution of Sum of Squares without hyper parameter
    w = inv((X' * X)) * X'*Y;
    
    % RMSE (Root Mean Square Error)
    sse = sum((Y - (w'*X')').^2); % sum square error
    rmse = sqrt(sse / numSamples); % root mean square error
    cvrmse = rmse / mean(Y);    % CV(RMSE)
    err = cvrmse;
end

