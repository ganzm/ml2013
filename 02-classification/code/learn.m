%% clean up & set up
clear
close all
clc
addpath('../toolbox/libsvm-3.17/matlab/');
addpath('./helperMethod');

%% load from libSvm
[Y_training_training, X_training_training] = libsvmread('../data/disease.train_train');
[Y_training_testing, X_training_testing] = libsvmread('../data/disease.train_testing');
[Y_testing, X_testing] = libsvmread('../data/disease.testing');
[Y_validation, X_validation] = libsvmread('../data/disease.validation');


%% look into the data manually
%plotPerFeatureCount(X_training_training,Y_training_training);
%plotPerFeatureCount(X_training_training(:,1),Y_training_training(:,1));

plotPerFeatureCount([X_training_training; X_training_testing],[Y_training_training; Y_training_testing]);


%%
%plotPerFeatureCount(X_training_testing(:,27),Y_training_testing(:,1));


%% Cross Validation for finding best C and gamma
[bestc, bestg] = crossvalidation(Y_training_training, X_training_training, true);
% 0.248:
%bestc = 1.4142
%bestg = 22.6274
% CV scale1: best log2c:0.5 best log2g:4.5 accuracy:92.8497%



%% Do svmtrain with best coefficiants
%cmdBest = ['-q  -w1 1 -w-1 5 -c ', num2str(bestc), ' -g ', num2str(bestg)];
cmdBest = ['-q  -w1 1 -w-1 500 -c ', num2str(bestc), ' -g ', num2str(bestg)];
model = svmtrain(Y_training_training, X_training_training, cmdBest);

%% predict on known(training) data
[predicted_label_training_training, accuracy_train, dec_values_train] = svmpredict(Y_training_training, X_training_training, model);

%% predict on known(testing) data
[predicted_label_training_testing, accuracy_test, dec_values_test] = svmpredict(Y_training_testing, X_training_testing, model);


%% show confusion matrix
%showConfusionMatrix(Y_training_training, predicted_label_training_training);
showConfusionMatrix(Y_training_testing, predicted_label_training_testing);


%% analyse what went wrong
% Mask wrong predicted
mask = predicted_label_training_testing-Y_training_testing ~= 0;
% All wrong ones
wrongOnes = [full(X_training_testing(mask,:)), Y_training_testing(mask), predicted_label_training_testing(mask)];
%for i = 1:size(X_training_testing,2)
%    disp(num2str(i))
%    feature_i = wrongOnes(:,[i,end-1,end]);
%    feature_i(feature_i(:,1) > 0.75,:)
%end



%% predict unknown Data
[predicted_label_testing, ~, ~] = svmpredict(Y_testing, X_testing, model, '-q');
[predicted_label_validation, ~, ~] = svmpredict(Y_validation, X_validation, model,'-q');

%% to think about: looks ok...
blub = full(X_validation);
predicted_label_validation(blub(:,27) > 0.5, :)


%% write output
writeOutput('../data/results/testResult.csv', predicted_label_testing);
writeOutput('../data/results/validationResult.csv', predicted_label_validation);

