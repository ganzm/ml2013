function [ bestErrorSoFar ] = LearnFunctionWithExtract( )
trainingData = csvread('../testdata/training.csv');
Y = trainingData(:,15);
X = trainingData(:,1:14);
X = extractFeatures(X);


index = find(X(:,1) >= 27 & Y(:,1) < 3.7e04);
X(index,:) = [];
Y(index,:) = [];

index = find(X(:,1) >= 18 & Y(:,1) < 2.6e04);
X(index,:) = [];
Y(index,:) = [];

bestErrorSoFar = learnFunction(X,Y);


end

