%% read raw csv data
trainingData = csvread('../testdata/training.csv');
testingData = csvread('../testdata/testing.csv');
validationData = csvread('../testdata/validation.csv');

[n, nColumns] = size(trainingData);

write_output = false;

%% feature extraction
Y_train = trainingData(:,15);
X_train = trainingData(:,1:14);

X_train = extractFeatures(X_train);

[Y_trainNormalized, transformParameter] = transform(Y_train);

%% perform crossvalidation
k = 100; % hyper parameter
meanErrs = 1:100;
kValues = 1:100;
for i=1:100
    [meanErr, W, errorTest] = crossvalidation(X_train, Y_trainNormalized, k);
    meanErrs(i) = meanErr;
    kValues(i) = k;
    
    % vary hyper parameters
    k = k/2;
end


%% Find best parameters
[minVal, minIndex] = min(meanErrs);
bestK = kValues(minIndex);
[bestW, bestError] = trainData(X_train, Y_trainNormalized, bestK);

%% compute error

Y_trainresult = X_train * bestW;
Y_trainResult = detransform(Y_trainresult, transformParameter);

sse = sum((Y_train - Y_trainresult).^2); % sum square error
rmse = sqrt(sse / n); % root mean square error
cvrmse = rmse / mean(Y_train);    % CV(RMSE)
disp(['Best RMSE Error is ' num2str(cvrmse)]);

%% compute result
Y_test = bestW'*X_test';

Y_validation = bestW'*X_validation';


disp(['Best Error is ' num2str(bestError)]);

%% Write output file

if write_output

    % create testing data
    X_test = extractFeatures(testingData);
    X_validation = extractFeatures(validationData);

%writeOutput( ['testresult-' num2str(bestError) '.txt'], Y_test);
%writeOutput( ['validation-' num2str(bestError) '.txt'], Y_validation);

end