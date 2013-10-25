function [ bestErrorSoFar ] = LearnFunctionWithExtract( )
trainingData = csvread('../testdata/training.csv');
Y = trainingData(:,15);
X = trainingData(:,1:14);
X = extractFeatures(X);



bestErrorSoFar = learnFunction(X,Y);


end

