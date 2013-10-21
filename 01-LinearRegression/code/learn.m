close all;

%% read raw csv data
trainingData = csvread('../testdata/training.csv');
[n, nColumns] = size(trainingData);


%% Test, remove me

tz = trainingData(:,1:14);
ty = transform(trainingData(:,15));

tzz = [ty, tz, tz.^2, tz.^3, tz.^4, sqrt(tz), log2(tz)];
tcorr = corr(tzz, tzz);
tc = tcorr(:,1);
tc = [tc(2:15), tc(16:29), tc(30:43), tc(44:57), tc(58:71), tc(72:85)];

% tc says how good a feature correlates to y


%% split big Matrix and feature extraction on X
Y = trainingData(:,15);

X = trainingData(:,1:14);
X = extractFeatures(X);

%% normailzation
[Xnorm, ~] = normalize(X);
%X = x2fx(X,'quadratic');
[Ynorm, denormParamY] = normalize(Y);


%% perform crossvalidation
kValues = logspace(-6, 2, 50); % hyper parameter
meanErrs = zeros(size(kValues));

for i=1:size(kValues,2)
    [meanErrs(i), W, errorTest] = crossvalidation(Xnorm, Ynorm, kValues(i));
end

%% Plot k-values and their corresponding errors
figure;
semilogx(kValues, meanErrs);
title('Ridge regression lambda values and their errors');

%% Find best parameters
[minVal, minIndex] = min(meanErrs);
bestK = kValues(minIndex);
[bestW, bestError] = trainData(Xnorm, Ynorm, bestK);

% estimate error CVRMSE
Y_trainresult = Xnorm * bestW;
Y_trainresult = denormalize(Y_trainresult, denormParamY);

sse = sum((Y - Y_trainresult).^2); % sum square error
rmse = sqrt(sse / n); % root mean square error
bestCVRMSE = rmse / mean(Y);    % CV(RMSE)

%plot k's vs errors (for finding out good k's)
disp(['best CVRMSE = ' num2str(bestCVRMSE)])
disp(['best K = ' num2str(bestK)])
disp(['best mean Error = ' num2str(minVal)])

%% compute results
computeResult(bestW, denormParamY, 0)
