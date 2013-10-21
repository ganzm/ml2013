%
% Input:
%      X        = m x n feature matrix
%      Y        = m x 1 vector representing the measured result
%      k        = a hyper parameter
function [ w, err ] = trainData( X, Y, k)

    [~, numFeatures] = size(X);
    
    % Closed form solution for Linear Regression
    %w = inv((X' * X)) * X'*Y;
    
    % Closed form solution for Ridge Regression
    w = (X'*X + k*eye(numFeatures))\X'*Y;
    
    % Calculate Error
    err = calcRMSE(X,Y,w);
end

