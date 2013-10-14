%% read raw csv data
trainingdata = csvread('../testdata/training.csv');
validationdata = csvread('../testdata/validation.csv');


%% normalize data
nTrainingdata = normalize(trainingdata);

%% plot data
%compare(training_data, [1 15; 2 15]);
%compare(trainingdata, [13 15]);
%compare(trainingdata, [14 15]);~


%% split them
Y = trainingdata(:,15);
X = trainingdata(:,1:14);

%% crossvalidation
[meanErr, W, errorTest] = crossvalidation(X, Y, 0);

%give index of smallest error
[~, index] = min(errorTest);

w = W{index};
Yest = computeEstimatedDelay(w, X);

%hist(Y-Yest)


