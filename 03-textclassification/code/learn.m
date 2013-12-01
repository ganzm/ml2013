

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


%% before making unique look at statistics
% all words
words = bagOfWords;
% how many words do we have
running_words = length(words);
% our vocabulary
vocabulary = unique(words);
% how many vocalbulary words do we have
vocabulary_words = length(vocabulary);
% which word has which frequency ( index contains pointers to the corresponding word in vocabulary for each running word in words. 
[vocabulary,void,index] = unique(words);
frequencies = hist(index,vocabulary_words);

%
[ranked_frequencies,ranking_index] = sort(frequencies,'descend');
ranked_vocabulary = vocabulary(ranking_index);

% here we could remove singletons and high frequency words
%hf_terms = (ranked_frequencies/max(ranked_frequencies))>0.02;
%lf_terms = ranked_frequencies<=5;
%pruned_ranked_vocabulary = ranked_vocabulary(not(hf_terms|lf_terms));

bagOfWords = ranked_vocabulary;

%% remove duplicates
% bagOfWords = unique(bagOfWords) % the old way

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
    X = createBooleanFeatures(trainingData, bagOfSimilarWords);
    save('x.mat', 'X');
end


if  exist('x_val.mat', 'file') 
    load('x_val.mat');
else 
    X_val = createBooleanFeatures(validationData, bagOfSimilarWords);
    save('x_val.mat', 'X_val');
end


if  exist('x_test.mat', 'file') 
    load('x_test.mat');
else 
    X_test = createBooleanFeatures(testingData, bagOfSimilarWords);
    save('x_test.mat', 'X_test');
end

%% KNN learn
mdlCountryCode = ClassificationKNN.fit(X, trainResult(:,2),'NSMethod','exhaustive',...
    'Distance','cosine');

mdlCityCode = ClassificationKNN.fit(X, trainResult(:,1),'NSMethod','exhaustive',...
    'Distance','cosine');

%% check country
mdlCountryCode.NumNeighbors = 5;
kfoldLoss(crossval(mdlCountryCode,'kfold',10))

%% check city
mdlCityCode.NumNeighbors = 13;
kfoldLoss(crossval(mdlCityCode,'kfold',10))



%% predict
cityCodeVal = predict(mdlCityCode, X_val);
countryCodeVal = predict(mdlCountryCode, X_val);


%% save
writeOutput('./result/validation_predicted.txt',cityCodeVal,countryCodeVal)

