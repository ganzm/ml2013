function [ bestErrorSoFar, trend ] = BackwardLearning(  )
%best CVRMSE = 0.17554 with CALCERROR 0.3, best-w dimension: 1298*1
trainingData = csvread('../testdata/training.csv');
%log
%trainingData(:, 8:9) = log2(trainingData(:,8:9));
%trainingData(:, 11:13) = log2(trainingData(:,11:13));



Y = trainingData(:,15);
X = trainingData(:,1:14);
X = extractFeatures(X);


bestErrorSoFar = learnFunction(X,Y);
disp(['we start with an error of: ', num2str(bestErrorSoFar)])
    trend = zeros(1,size(X,2));
    for i = 1:size(X,2)
        Xcopy = X;
        Xcopy(:,i) = [];
        errorNow = learnFunction(Xcopy,Y);
        trend(i)=bestErrorSoFar-errorNow; %delete this one
    end
    trend  = trend';
     trend =[trend, find(trend>-100)+37];
    

end

