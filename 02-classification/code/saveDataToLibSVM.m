function[] = saveDataToLibSVM(applyOnAll)

%% clean up
%clear
close all
clc

%% set up
addpath('../toolbox/libsvm-3.17/matlab/');
addpath('../data/origin/');

%% read raw csv data
trainingDataRaw = csvread('training.csv');
testingDataRaw = csvread('testing.csv');
validationDataRaw = csvread('validation.csv');

%% split data
X_training = trainingDataRaw(:,1:end-1);
Y_training = trainingDataRaw(:,end);


%% feature manipulations Sum up to 3
%X_meanIntensity = X_training(:,1:3:27);
%X_meanGradient = X_training(:,2:3:27);
%X_varianceGradient = X_training(:,3:3:27);
%X_meanIntensitySum = sum(X_meanIntensity,2);
%X_meanGradientSum = sum(X_meanGradient,2);
%X_varianceGradientSum = sum(X_varianceGradient,2);

%X_training = [X_meanIntensitySum, X_meanGradientSum, X_varianceGradientSum];

%% lukes best features
%X_training = [X_training(:,1).^2, X_training(:,5).^3, 1./X_training(:,23), exp(X_training(:,25)), log(X_training(:,27))];

%% brute Force

%X_basic = X_training;
%X_training = [X_basic, X_basic.^2, X_basic.^3, log2(X_basic), 1./X_basic, exp(X_basic)];%
%X_training = [X_basic];

%for first=1:size(X_basic,2)-1
%   for second=2:size(X_basic,2)
%      X_training = [X_training, X_training(:,first).*X_training(:,second)]; 
%   end
%end



%% scale training data and do the same for testing and validation (same scaling factor)
minimums = min(X_training, [], 1);
ranges = max(X_training, [], 1) - minimums;
X_training = (X_training - repmat(minimums, size(X_training, 1), 1)) ./ repmat(ranges, size(X_training, 1), 1);

if strcmp(applyOnAll,'onlyTrain') ~= 1
    X_testing  = (testingDataRaw - repmat(minimums, size(testingDataRaw, 1), 1)) ./ repmat(ranges, size(testingDataRaw, 1), 1);
    X_validation = (validationDataRaw - repmat(minimums, size(validationDataRaw, 1), 1)) ./ repmat(ranges, size(validationDataRaw, 1), 1);
end

%% ATTENTION TO CHECK what is better 0:1 or -1:1




%% split Training into Training_Test and Tranining_Train (Ratio arround 66 and 33)
indices = crossvalind('Kfold',Y_training,3);
Y_training_testing = Y_training(indices == 2,:);
X_training_testing = X_training(indices == 2,:);
X_training_training = X_training(indices ~= 2,:);
Y_training_training = Y_training(indices ~= 2,:);


%% eifach mal par user?ere
%X_normal = X_training_training(Y_training_training == 1);
%Y_normal = Y_training_training(Y_training_training == 1);
%X_disease = X_training_training(Y_training_training == -1);
%Y_disease = Y_training_training(Y_training_training == -1);
%
%X_training_training = [X_normal; X_disease(1:100,:)];
%Y_training_training = [Y_normal; Y_disease(1:100,:)];

%% sparce matrices to be svm compatible
X_training_training = sparse(X_training_training);
X_training_testing = sparse(X_training_testing);
if strcmp(applyOnAll,'onlyTrain') ~= 1
    X_testing = sparse(X_testing);
    X_validation = sparse(X_validation);
end

%% save file to disk
libsvmwrite('../data/disease.train_train', Y_training_training, X_training_training);
libsvmwrite('../data/disease.train_testing', Y_training_testing, X_training_testing);
if strcmp(applyOnAll,'onlyTrain') ~= 1
    libsvmwrite('../data/disease.testing', zeros(size(X_testing,1),1), X_testing);
    libsvmwrite('../data/disease.validation', zeros(size(X_validation,1),1), X_validation);
end

disp 'finished'

end

