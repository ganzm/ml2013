%% read raw csv data
trainingdata = csvread('../testdata/training.csv');
validationdata = csvread('../testdata/validation.csv');

% Settings
trainingdataPath = '../testdata/training.csv';
testingdataPath = '../testdata/testing.csv';
validationdataPath = '../testdata/validation.csv';

%% read raw csv data
trainingData = csvread(trainingdataPath);
testingData = csvread(testingdataPath);
validationData = csvread(validationdataPath);

[n, nColumns] = size(trainingdata);


%% feature extraction
Y = trainingData(:,15);

X = extractFeatures(trainingData);
X_test = extractFeatures(testingData);
X_validation = extractFeatures(validationData);

%% normalize data
% dMean = repmat(mean(X), n, 1);
% dVar = repmat(var(X), n, 1);
% 
% X = (X - dMean) ./ dVar;

%% perform crossvalidation

k = 100;    % hyper parameter
meanErrs = 1:100;
kValues = 1:100;
for i=1:100
    [meanErr, W, errorTest] = crossvalidation(X, Y, k);
    meanErrs(i) = meanErr;
    kValues(i) = k;
    
    % vary hyper parameters
    k = k/2;
end


%% Find best parameters
[minVal, minIndex] = min(meanErrs);
bestK = kValues(minIndex);
[bestW, bestError] = trainData(X, Y, bestK);

%% compute result
Y_test = bestW'*X_test';
Y_validation = bestW'*X_validation';


%% Write output file
writeOutput( ['testresult-' num2str(bestError) '.txt'], Y_test);
writeOutput( ['validation-' num2str(bestError) '.txt'], Y_validation);
