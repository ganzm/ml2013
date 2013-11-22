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

%% training data
X_train = training_data(:, 1:27);
Y_train = training_data(:, 28); % expected solution


%% modify features
%0.1299239806496199 
X_train(:,1:3:27) = 1./(X_train(:,1:3:27)+2);
validation_data(:,1:3:27) = 1./(validation_data(:,1:3:27)+2);
testing_data(:,1:3:27) = 1./(testing_data(:,1:3:27)+2);


%0.13199723565998617 
%X_train(:,1:3:27) = 1./(X_train(:,1:3:27)+2).^2;
%validation_data(:,1:3:27) = 1./(validation_data(:,1:3:27)+2).^2;
%testing_data(:,1:3:27) = 1./(testing_data(:,1:3:27)+2).^2;

%% plot two features
normal = X_train(Y_train == 1,:);
dis = X_train(Y_train == -1,:);

plot(normal(:,1), normal(:,4), 'g+');
hold on
plot(dis(:,1), dis(:,4), 'r+');


%% parameters found with cross validation
c_best = 1.1;
sigma_best = 0.553266;

%% compute svm with all values
SVMstruct = svmtrain(X_train,Y_train,'Kernel_Function', 'rbf', 'rbf_sigma', sigma_best, 'boxconstraint', c_best);
    
%% compute validation solution
X_validation = validation_data(:,1:27);
Y_validation = 	svmclassify(SVMstruct,X_validation);

writeOutput('data/results/validation_predicted.txt', Y_validation);

%% compute testing solution
X_testing = testing_data(:,1:27);
Y_testing = svmclassify(SVMstruct,X_testing);

writeOutput('data/results/testing_predicted.txt', Y_testing);