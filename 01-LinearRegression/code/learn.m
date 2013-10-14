%% read raw csv data
trainingdata = csvread('../testdata/training.csv');
validationdata = csvread('../testdata/validation.csv');


%% normalize data
%nTrainingdata = normalize(trainingdata);

%% plot data
%compare(training_data, [1 15; 2 15]);
%compare(trainingdata, [13 15]);
%compare(trainingdata, [14 15]);~


%% feature extraction
[X, Y] = extractFeatures(trainingdata);

%% crossvalidation
k = 100;    % hyper parameter
meanErrs = [1,100];
for i=1:100
    [meanErr, W, errorTest] = crossvalidation(X, Y, k);
    meanErrs(i) = meanErr;
    k = k/2;
end

%% Find best parameters
min(meanErrs)

%give index of smallest error
%[~, index] = min(errorTest);
%w = W{index};
%Yest = computeEstimatedDelay(w, X);

%hist(Y-Yest)


