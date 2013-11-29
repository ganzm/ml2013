

%% add editing stance algos
addpath('edit_distances');

%% easy baseline
baseline_easy = 3973.75;

%% erase local variables
clear all;

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
bagOfSimilarWords = createBagOfSimilarWords(bagOfWords);

