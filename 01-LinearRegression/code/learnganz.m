function [] = learnganz()

%% read raw csv data
testingData = csvread('../testdata/testing.csv');
trainingData = csvread('../testdata/training.csv');
validationData = csvread('../testdata/validation.csv');

% extract data
Xraw = trainingData(:,1:14);
Y = trainingData(:,15);

X13 =  extractFeature13(Xraw);

X13t =  extractFeature13(testingData);
X13v =  extractFeature13(validationData);

%% perform crossvalidation
kValues = logspace(-6, 2, 50); % hyper parameter
numX13 = size(X13,2);

for j=1:numX13
    X13j = X13(:,j);
    Yj = Y;
    
    zeroIndices = (X13j == 0);
    X13j(zeroIndices) = [];
    Yj(zeroIndices) = [];

    meanErrs = zeros(size(kValues));
    for i=1:size(kValues,2)
        [meanErrs(i), ~, ~] = crossvalidation(X13j, Yj, kValues(i));
    end

    [~, bestKIndex] = min(meanErrs);
    [w, ~] = trainData(X13j, Yj, kValues(bestKIndex));
    
    weight(j) = w;
end

Ytrain = estimateValues(X13, weight);
Ytest = estimateValues(X13t, weight);
Yvalidation = estimateValues(X13v, weight);

%% caluculate CVRMSE
sse = sum((Y -  Ytrain).^2); % sum square error
error = sqrt(sse /size(Y,1)); % root mean square error
error = error/mean(Y);
    
disp(['CVRMSE: ' num2str(error)]);

writeOutput( 'out-test.txt', Ytest);
writeOutput( 'out-validation.txt', Yvalidation);


end
%%

function [y] = estimateValues(X13, w)

y = zeros(size(X13,1),1);

    for i = 1:size(X13,2)
        y = y + (X13(:,i) * w(i));
    end
end

function [X13] = extractFeature13(Xraw)
    X13 = [];
    group13 = groupBy(Xraw(:,13));
    for groupIndex=1:length(group13)
        temp = group13(groupIndex);
        newFeature = Xraw(:,14);
        newFeature(Xraw(:,13) ~= temp) = 0;
        X13(:,end+1) = newFeature;
    end
end