%% Parameter Description
% Input:
%  1 = city name 
%
% Output:
%  2 = 6-digit city code (122 total codes)
%  3 = 3-digit country code (15 total codes)

%% load data
[training_data, training_result] = dataread('02_data/training.csv');
[validation_data, ~] = dataread('02_data/validation.csv');
[testing_data, ~] = dataread('02_data/testing.csv');

nSamples = length(training_data);

%% preprocessing
fprintf('build Dictionary\n');
dictionary = buildDictionary(training_data);
X_train = extractFeatures(training_data, dictionary);
Y_train_city = training_result(:, 1);
Y_train_country = training_result(:, 2);

%% find solution
%Y_train_country_predicted = knnclassify(X_train, X_train, Y_train_country);
%Y_train_city_predicted = knnclassify(X_train, X_train, Y_train_city);

%% evaluate train solution
%[ce, nWrongCountries, nWrongCities] = classificationError(Y_train_country_predicted, Y_train_city_predicted, Y_train_country, Y_train_city);
%fprintf('ce = %.2f, #wrong cities = %d, #wrong countries = %d\n', ce, nWrongCities, nWrongCountries);

%% compute validation solution
fprintf('compute validation solution\n');
X_validation = extractFeatures(validation_data, dictionary);
Y_validation_country_predicted = knnclassify(X_validation, X_train, Y_train_country, 10);
%Y_validation_city_predicted = knnclassify(X_validation, X_train, Y_train_city);

Y_validation_city_predicted = zeros(size(Y_validation_country_predicted));
countries = unique(Y_validation_country_predicted);
for i=1:length(countries)
    country = countries(i);
    validation_index = find(Y_validation_country_predicted == country);

    train_index = find(Y_train_country == country);
    validation_values = knnclassify(X_validation(validation_index, :), X_train(train_index, :), Y_train_city(train_index), 10);
    Y_validation_city_predicted(validation_index) = validation_values;
end

writeOutput('02_data/validation_predicted.txt', Y_validation_city_predicted, Y_validation_country_predicted);

%% compute testing solution
%X_testing = extractFeatures(testing_data, dictionary);
%Y_testing_country_predicted = knnclassify(X_testing, X_train, Y_train_country);
%Y_testing_city_predicted = knnclassify(X_testing, X_train, Y_train_city);

%writeOutput('02_data/testing_predicted.txt', Y_testing_city_predicted, Y_testing_country_predicted);