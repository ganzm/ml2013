function [ ] = computeResult( w, denormParamY, generateFiles)
%% read raw csv data
testingData = csvread('../testdata/testing.csv');
validationData = csvread('../testdata/validation.csv');

%% split big Matrix and feature extraction on X
X_test = testingData(:,1:14);
X_validation = validationData(:,1:14);

X_test = extractFeatures(X_test);
X_validation = extractFeatures(X_validation);


%% normailzation
[X_test, ~] = normalize(X_test);
[X_validation, ~] = normalize(X_validation);

%X_test = x2fx(X_test,'quadratic');
%X_validation = x2fx(X_validation,'quadratic');


%% add row with one 
X_test = [ones(size(X_test,1),1),X_test];
X_validation = [ones(size(X_validation,1),1),X_validation];

%% compute result
Y_test = w'*X_test';
Y_validation = w'*X_validation';

%% denormalize Y
Y_test = denormalize(Y_test,denormParamY);
Y_validation = denormalize(Y_validation,denormParamY);

disp(['we have ' num2str(size(Y_test(Y_test < 0),1)) ' negative values in Y_test'])
disp(['we have ' num2str(size(Y_validation(Y_validation < 0),1)) ' negative values in Y_validation'])
%% Write output file
if generateFiles == 1
    writeOutput( ['testresult-' num2str(datestr(now)) '.txt'], Y_test);
    writeOutput( ['validation-' num2str(datestr(now)) '.txt'], Y_validation);
end

end

