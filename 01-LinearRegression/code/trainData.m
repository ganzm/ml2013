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
    for i=1:numSamples
       err = err + (Y(i) -  w' * X(i, :)')^2;
    end
    err = sqrt(err / numSamples);
end

