% crossvalidation
%
% Input:
%   features        - k x n 
%   expectedResult  - k x 1 
%   hyperparameter  - struct with different parameters
%   
% Output:
%   meanerr       - mean CV(RMSE)
%   W             - 1 x K Vector containing different w
%   errorTest     - 1 x K Vector containing the generalized CV(RMSE)
%


function [ meanErr, W, errorTest] = crossvalidation( X, Y, hyperparameter)

%Indices for crossvalidation
K=10;
indices = crossvalind('Kfold',Y,K);


%for each bucket do crossvalidation
errorTrain = zeros(1,K);
errorTest = zeros(1,K);
W = cell(1,K);
for i = 1:K
    test = (indices == i);
    train = ~test;
    Xtrain = X(train,:);
    Ytrain = Y(train,:);
    
    
    [W{i}, errorTrain(i)] = trainData(Xtrain, Ytrain, hyperparameter);
   
    
    Ytest = Y(test,:);
    Xtest = X(test,:);
    
    % Calculate Error
    errorTest(i) = calcRMSE(Xtest, Ytest, W{i});
    
end
meanErr = sum(errorTest)/K;
end

