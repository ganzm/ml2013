% crossvalidation
%
% Input:
%   features        - k x n descriptor of first image
%   expectedResult  - k x 1 descriptor of second image
%   hyperparameter  - struct with different parameters
%   
% Output:
%   meanerr       - 2 x w matrix storing the indices of the matching
%                   descriptors


function [ meanErr ] = crossvalidation( X, Y, hyperparameter)

%[numSamples, numFeatures] = size(features);
%[numResultSamples, ~] = size(expectedResult);


%Indices for crossvalidation
K=10;
indices = crossvalind('Kfold',Y,K);


%for each bucket do crossvalidation
errorTrain = zeros(1,K);
errorTest = zeros(1,K);
for i = 1:K
    test = (indices == i);
    train = ~test;
    Xtrain = X(train,:);
    Ytrain = Y(train,:);
    
    
    [w, errorTrain(i)] = trainData(Xtrain, Ytrain, hyperparameter);
   
    
    Ytest = Y(test,:);
    Xtest = X(test,:);
    
    sse = sum((Ytest -  (w' * Xtest')').^2);
    rmse = sqrt(sse /size(Ytest,1));
    
    errorTest(i) = rmse / mean(Ytest);
    
 
end
errorTrain
errorTest

meanErr = sum(errorTest)/K;
end

