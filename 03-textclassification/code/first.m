%%
% This file checks obvious typos
% First we build a vocab based on frequency, all words which occurs only
% one will be checked against the words who appears at least twice. if the
% levensthein distance is <= 1 (or something) we update the word


%% add editing stance algos
addpath('edit_distances');


%% erase local variables
clear all;

%% read raw csv data
[Training.trainingData, Training.trainResult] = dataread('data/training.csv');
[Testing.testingData, ~] = dataread('data/testing.csv');
[Validation.validationData, ~] = dataread('data/validation.csv');


%% create Bag of Words / RankedVocab
% calculate bag of words
Global.Words = cell(0,0);
Global.Words = addToBagOfWords(Global.Words, Training.trainingData);
Global.Words = addToBagOfWords(Global.Words, Testing.testingData);
Global.Words = addToBagOfWords(Global.Words, Validation.validationData);

% createRankedVocabulary
[Global.Ranked_Vocabulary, Global.Ranked_Vocabulary_Frequencies] = createRankedVocabulary(Global.Words);





%% create List for Typo Words
Global.TypoList = createTypoList(Global);


% update Typos to validationData, trainingData and testingData
Validation.validationData =  updateTypos(Validation.validationData, Global);
Testing.testingData =  updateTypos(Testing.testingData, Global);
Training.trainingData =  updateTypos(Training.trainingData, Global);


% create Bag of Words / RankedVocab
% calculate bag of words
Global.Words = cell(0,0);
Global.Words = addToBagOfWords(Global.Words, Training.trainingData);
Global.Words = addToBagOfWords(Global.Words, Testing.testingData);
Global.Words = addToBagOfWords(Global.Words, Validation.validationData);

% createRankedVocabulary
[Global.Ranked_Vocabulary, Global.Ranked_Vocabulary_Frequencies] = createRankedVocabulary(Global.Words);

size(Global.Ranked_Vocabulary)

%% Now we check stemming

Global.StemmList = createStemmList(Global);

% update Stemmings to validationData, trainingData and testingData
Validation.validationData =  updateStemming(Validation.validationData, Global);
Testing.testingData =  updateStemming(Testing.testingData, Global);
Training.trainingData =  updateStemming(Training.trainingData, Global);


% create Bag of Words / RankedVocab
% calculate bag of words
Global.Words = cell(0,0);
Global.Words = addToBagOfWords(Global.Words, Training.trainingData);
Global.Words = addToBagOfWords(Global.Words, Testing.testingData);
Global.Words = addToBagOfWords(Global.Words, Validation.validationData);

% createRankedVocabulary
[Global.Ranked_Vocabulary, Global.Ranked_Vocabulary_Frequencies] = createRankedVocabulary(Global.Words);

size(Global.Ranked_Vocabulary)




%% here we could remove singletons and high frequency words
% Global.HFLFList = createHFLFList(Global);
% 
% %% update HFLFLIst to validationData, trainingData and testingData
% Validation.validationData =  updateHFLFList(Validation.validationData, Global);
% Testing.testingData =  updateHFLFList(Testing.testingData, Global);
% Training.trainingData =  updateHFLFList(Training.trainingData, Global);
% 
% 
% %% create Bag of Words / RankedVocab
% % calculate bag of words
% Global.Words = cell(0,0);
% Global.Words = addToBagOfWords(Global.Words, Training.trainingData);
% Global.Words = addToBagOfWords(Global.Words, Testing.testingData);
% Global.Words = addToBagOfWords(Global.Words, Validation.validationData);
% 
% % createRankedVocabulary
% [Global.Ranked_Vocabulary, Global.Ranked_Vocabulary_Frequencies] = createRankedVocabulary(Global.Words);


%% save 'Global','Training','Testing','Validation' to AllData
save('ALLData','Global','Training','Testing','Validation');
clear all


