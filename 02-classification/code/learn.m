%% clean up & set up
clear
close all
clc
addpath('../toolbox/libsvm-3.17/matlab/');

%% load from libSvm
[Y_training_training, X_training_training] = libsvmread('../data/disease.train_train');
[Y_training_testing, X_training_testing] = libsvmread('../data/disease.train_testing');
[Y_testing, X_testing] = libsvmread('../data/disease.testing');
[Y_validation, X_validation] = libsvmread('../data/disease.validation');


%% Cross Validation for finding best C and gamma
[bestc, bestg] = crossvalidation(Y_training_training, X_training_training, true);
% best so far:
%bestc = 4.9246;
%bestg = 24.2515;


%% Do svmtrain with best coefficiants
cmdBest = ['-q  -w1 1 -w-1 5 -c ', num2str(bestc), ' -g ', num2str(bestg)];
model = svmtrain(Y_training_training, X_training_training, cmdBest);

%% predict on known(training) data
[predicted_label_training, accuracy_train, dec_values_train] = svmpredict(Y_training_training, X_training_training, model);

%% predict on known(testing) data
[predicted_label_testing, accuracy_test, dec_values_test] = svmpredict(Y_training_testing, X_training_testing, model);


%% show confusion matrix
%showConfusionMatrix(Y_training_training, predicted_label_training);
showConfusionMatrix(Y_training_testing, predicted_label_testing);

%% predict unknown Data
[predicted_label_testing, ~, ~] = svmpredict(Y_testing, X_testing, model, '-q');
[predicted_label_validation, ~, ~] = svmpredict(Y_validation, X_validation, model,'-q');


%% write output
writeOutput('../data/results/testResult.csv', predicted_label_testing);
writeOutput('../data/results/validationResult.csv', predicted_label_validation);

