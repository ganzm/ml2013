function [ bestErrorSoFar ] = BackwardLearning(  )
%best CVRMSE = 0.17554 with CALCERROR 0.3, best-w dimension: 1298*1
trainingData = csvread('../testdata/training.csv');
%log
%trainingData(:, 8:9) = log2(trainingData(:,8:9));
%trainingData(:, 11:13) = log2(trainingData(:,11:13));



Y = trainingData(:,15);
X = trainingData(:,1:14);
X = extractFeatures(X);
canImprove = 1;

bestErrorSoFar = learnFunction(X,Y);
disp(['we start with an error of: ', num2str(bestErrorSoFar)])
while canImprove
    deletes = zeros(1,size(X,2));
    for i = 1:size(X,2)
        Xcopy = X;
        Xcopy(:,i) = [];
        errorNow = learnFunction(Xcopy,Y);
        if errorNow < bestErrorSoFar %better solution now
           deletes(i)=1; %delete this one
           bestErrorSoFar = errorNow;
           X =Xcopy;
           disp('improved')
           canImprove = 1;
            break
        end
        deletes(i)=0;
        canImprove = 0; %keep this one
    end
    deletes
end


end

