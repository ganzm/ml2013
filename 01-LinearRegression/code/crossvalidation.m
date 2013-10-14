function [ meanErr ] = crossvalidation( features, expectedResult, hyperparameter)

%CROSSVALIDATION Summary of this function goes here
%   Detailed explanation goes here
% feature(:,1) wäre bsp. cache size

[numSamples, numFeatures] = size(features);
[numResultSamples, ~] = size(expectedResult);

if numSamples ~= numResultSamples 
    error 'blub';
end


% loop create buckets
% do crossvalidation

[w, err] = train(features(1:10, expectedResult), hyperparameter);
% TODO
% least square fitting

meanErr = 0;
end

