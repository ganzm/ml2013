%% Parameter Description
%  1 = mean intensity 
%  2 = mean of gradient values
%  3 = variance of gradient values
%  ... total of neighborhoods = 9 (each of those has the above 3 values)
% 28 = 1 = normal, -1 = disease (Output)

%% load data
training_data = csvread('data/origin/training.csv');
validation_data = csvread('data/origin/validation.csv');
testing_data = csvread('data/origin/testing.csv');
nSamples = size(training_data,1);

%% train
X_train = training_data(:, 1:27);
Y_train = training_data(:, 28); % expected solution

%% find solution
SVMstruct = svmtrain(X_train,Y_train,'Kernel_Function','rbf', 'rbf_sigma', 0.5);

%% evaluate train solution
[ce, nWrongMatches] = classificationError(svmclassify(SVMstruct,X_train), Y_train)

%% compute validation solution
X_validation = validation_data(:,1:27);
Y_validation = 	svmclassify(SVMstruct,X_validation);

writeOutput('data/results/validation_predicted.txt', Y_validation);

%% compute testing solution
X_testing = testing_data(:,1:27);
Y_testing = svmclassify(SVMstruct,X_testing);

writeOutput('data/results/testing_predicted.txt', Y_testing);