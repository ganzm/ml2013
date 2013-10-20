close all;

%% read raw csv data
trainingData = csvread('../testdata/training.csv');
testingData = csvread('../testdata/testing.csv');
validationData = csvread('../testdata/validation.csv');

[n, nColumns] = size(trainingData);

write_output = true;

%% feature extraction
Y_train = trainingData(:,15);
[Y_trainNormalized, transformParameter] = transform(Y_train);

X_train = trainingData(:,1:14);
X_train = extractFeatures(X_train);

X_test = testingData(:,1:14);
X_test = extractFeatures(X_test);

X_validation = validationData(:,1:14);
X_validation = extractFeatures(X_validation);

%% perform crossvalidation
kValues = logspace(-6, 1, 50); % hyper parameter
meanErrs = zeros(size(kValues));

for i=1:size(kValues,2)
    k = kValues(i);
    [meanErr, W, errorTest] = crossvalidation(X_train, Y_trainNormalized, k);
    meanErrs(i) = meanErr;
end


%% Plot k-values and their corresponding errors
figure 
semilogx(kValues, meanErrs);
title('Ridge regression lambda values and their errors');

%% Find best parameters
[minVal, minIndex] = min(meanErrs);
bestK = kValues(minIndex);
[bestW, bestError] = trainData(X_train, Y_trainNormalized, bestK);

%% compute error

Y_trainresult = X_train * bestW;
Y_trainresult = detransform(Y_trainresult, transformParameter);

sse = sum((Y_train - Y_trainresult).^2); % sum square error
rmse = sqrt(sse / n); % root mean square error
cvrmse = rmse / mean(Y_train);    % CV(RMSE)
disp(['Best RMSE Error is ' num2str(cvrmse)]);

%% compute result
Y_test =       bestW'* X_test';
Y_test = detransform(Y_test, transformParameter);

Y_validation = bestW'* X_validation';
Y_validation = detransform(Y_validation, transformParameter);

disp(['Best Error is ' num2str(bestError)]);

%% Write output file
if write_output
    
    bestError = 0;
    
    writeOutput( ['testresult-' num2str(bestError) '.txt'], Y_test);
    writeOutput( ['validation-' num2str(bestError) '.txt'], Y_validation);
end