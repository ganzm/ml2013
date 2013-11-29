

%% add editing stance algos
addpath('edit_distances');

%% easy baseline
baseline_easy = 3973.75;

%% erase local variables
clear all;

%% read data
parseFiles = true;

if  exist('trainingData.mat', 'file') && ... 
    exist('trainResult.mat', 'file') &&  ...
    exist('testingData.mat', 'file') &&  ...
    exist('validationData.mat', 'file') 
   
    parseFiles = false;
end

%% read raw csv data
if parseFiles
    [trainingData, trainResult] = dataread('data/training.csv');
    [testingData, ~] = dataread('data/testing.csv');
    [validationData, ~] = dataread('data/validation.csv');

    % save stuff
    save('trainingData.mat', 'trainingData');
    save('trainResult.mat', 'trainResult');
    save('testingData.mat', 'testingData');
    save('validationData.mat', 'validationData');
else 
    % load stuff
    load('trainingData.mat');
    load('trainResult.mat');
    load('testingData.mat');
    load('validationData.mat'); 
end

%% calculate bag of words
bagOfWords = cell(0,0);
bagOfWords = addToBagOfWords(bagOfWords, trainingData);
bagOfWords = addToBagOfWords(bagOfWords, testingData);
bagOfWords = addToBagOfWords(bagOfWords, validationData);

% remove duplicates
bagOfWords = unique(bagOfWords);

%% create bag of similar words
if  exist('bagOfSimilarWords.mat', 'file') 
    load('bagOfSimilarWords.mat');
else 
    bagOfSimilarWords = createBagOfSimilarWords(bagOfWords);
    save('bagOfSimilarWords.mat', 'bagOfSimilarWords');
end

%% generate feature vector

if  exist('x.mat', 'file') 
    load('x.mat');
else 
    x = createBooleanFeatures(trainingData, bagOfSimilarWords);
    save('x.mat', 'x');
end


if  exist('x_val.mat', 'file') 
    load('x_val.mat');
else 
    x_val = createBooleanFeatures(validationData, bagOfSimilarWords);
    save('x_val.mat', 'x_val');
end


if  exist('x_test.mat', 'file') 
    load('x_test.mat');
else 
    x_test = createBooleanFeatures(testingData, bagOfSimilarWords);
    save('x_test.mat', 'x_test');
end
