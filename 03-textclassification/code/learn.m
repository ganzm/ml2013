%run first.m first


%% add editing stance algos
addpath('edit_distances');

%% easy baseline
baseline_easy = 3973.75;

%% erase local variables
clear all;


%% load All Data
%load('ALLData.mat');

%% build dictionary city->country
Global.Dictionary = createRankedDictionary(Training.trainResult);


%% create bag of similar words
%if  not(isfield(Global,'BagOfSimilarWords'))
%    Global.BagOfSimilarWords = createBagOfSimilarWords(Global.Ranked_Vocabulary);
%end

%% generate feature vector
Global.BagOfSimilarWords = Global.Ranked_Vocabulary;


%if  not(isfield(Training,'X'))
    Training.X = createBooleanFeatures(Training.trainingData, Global.BagOfSimilarWords);
%end
%if  not(isfield(Validation,'X_val'))
    Validation.X_val = createBooleanFeatures(Validation.validationData, Global.BagOfSimilarWords);
%end
%if  not(isfield(Testing,'X_test'))
    Testing.X_test = createBooleanFeatures(Testing.testingData, Global.BagOfSimilarWords);
%end

%% sandro output
csvwrite('X-val.csv', Validation.X_val);
csvwrite('X-test.csv', Testing.X_test);
csvwrite('X.csv', Training.X);

%% remove outliers
% size(Training.X)
% Training = removeOutliers(Training);
% size(Training.X)


%% clean up HF words Training.X(:,1:10) = []; for all three
while true
[~,indexX] = max(sum(Training.X));
[~,indexX_val] = max(sum(Validation.X_val));
[~,indexX_test] = max(sum(Testing.X_test));

if (indexX == indexX_val) &&  (indexX_val == indexX_test)
    disp(['removing index: ', num2str(indexX),'/',num2str(indexX_test),'/',num2str(indexX_val)])
   Training.X(:,indexX) = []; 
   Validation.X_val(:,indexX) = []; 
   Testing.X_test(:,indexX) = []; 
else
    break
end
end
%% clean up LF words Training.X(:,235:end) = []; for all three
size(Training.X)

[~,indexX] = min(sum(Training.X));
[~,indexX_val] = min(sum(Validation.X_val));
[~,indexX_test] = min(sum(Testing.X_test));

indexX = max([indexX indexX_test indexX_val]);

Training.X(:,indexX:end) = [];
Validation.X_val(:,indexX:end) = [];
Testing.X_test(:,indexX:end) = [];

size(Training.X)




% %%
% % size(Training.X)
% % procentual =(Global.Ranked_Vocabulary_Frequencies/sum(Global.Ranked_Vocabulary_Frequencies));
% % index = find(procentual < 0.0001);
% % index = index(1);
% % Training.X(:,index:end) = [];
% % Testing.X_test(:,index:end) = [];
% % Validation.X_val(:,index:end) = [];
% % size(Training.X)
% 
% %% save as libsvm
% addpath('../toolbox/libsvm-3.17/matlab/');
% 
% X_training = sparse(Training.X);
% X_testing = sparse(Testing.X_test);
% X_validation = sparse(Validation.X_val);
% libsvmwrite('../toolbox/cmdData/train_Country', Training.trainResult(:,2), X_training);
% libsvmwrite('../toolbox/cmdData/train_City', Training.trainResult(:,1), X_training);
% libsvmwrite('../toolbox/cmdData/testing', zeros(size(X_testing,1),1), X_testing);
% libsvmwrite('../toolbox/cmdData/validation', zeros(size(X_validation,1),1), X_validation);
% 
% 
% %% checking
% 
% cityCodeTrain = Training.trainResult(:,1);
% countryCodeTrain = Training.trainResult(:,2);
% 
% lookedUpCountry = zeros(length(cityCodeTrain),1);
% for i = 1:length(cityCodeTrain)
%     lookedUpCountry(i,1) = Global.Dictionary(Global.Dictionary(:,1) ==  cityCodeTrain(i,1),2);
% end
% 
% all = [cityCodeTrain, countryCodeTrain, lookedUpCountry];
% 
% %%
% for i = 1:size(Training.X,1)
%     if(all(i,2)-all(i,3) == 0)
%         continue % we have already right predicted
%     end
%     
%     
%    Xi = Training.X(i,:);
%    predictedCountryNN = all(i,2); %assume: should be right!
%    
%    indexForCurrentCountries = (countryCodeTrain == predictedCountryNN);
%    cityCodeTrain(indexForCurrentCountries);
%    [sorted, indexOfSorted] =  sort(cityCodeTrain(indexForCurrentCountries));
%    XBasedOnCountry = Training.X(indexForCurrentCountries,:);
%    XtoInspect = XBasedOnCountry(indexOfSorted,:); 
%    
%    weightVector = (XtoInspect*Xi')';
%    
%    
%    uniqueSorted = unique(sorted);
%    whichCityMap = zeros(size(uniqueSorted,1),1);
%    for j=1:size(uniqueSorted)
%         
%        CurrentAvgOfCity = uniqueSorted(j,1);
%        logicalVector = (sorted == CurrentAvgOfCity);
%        
%        summOfCities = sum(logicalVector);
%        startIndex = find(logicalVector,1);
%        stopIndex = find(logicalVector,1,'last');
%        
%        avg = (sum(weightVector(startIndex:stopIndex))/summOfCities);
%        
%        whichCityMap(j,1) = avg;
%    end
%    
%    replacement = uniqueSorted(whichCityMap == max(whichCityMap));
%    replacement = replacement(end); % take last WTF
%    
%    disp(['changing from: ', num2str(cityCodeTrain(i,1)), ' to: ', num2str(replacement)])
%   cityCodeTrain(i,1) = replacement;
%    
% end
%     
% Training.trainResult(:,1) = cityCodeTrain;    
%     
%     
% 
% %%
% warning('off','stats:pdist2:ZeroPoints')
% %% KNN learn country
% mdlCountryCode = ClassificationKNN.fit(Training.X, Training.trainResult(:,2),'NSMethod','exhaustive',...
%     'Distance','cosine'); %cosine
% 
% bestLossCountry = 1;
% bestNumNeighborCountry = 1;
% for numNeigbhbor=16:22
%     disp(['checking: ', num2str(numNeigbhbor)])
%     mdlCountryCode.NumNeighbors = numNeigbhbor;
%     currentLossCountry = kfoldLoss(crossval(mdlCountryCode,'kfold',10));
%     if currentLossCountry < bestLossCountry
%         bestLossCountry = currentLossCountry
%         bestNumNeighborCountry = numNeigbhbor
%     end
%     
% end
% 
% % city
% % mdlCityCode = ClassificationKNN.fit(Training.X, Training.trainResult(:,1),'NSMethod','exhaustive',...
% %    'Distance','cosine');
% 
% mdlCityCode = ClassificationKNN.fit(Training.X, Training.trainResult(:,1),'NSMethod','exhaustive',...
%     'Distance','cosine');
% 
% 
% bestLossCity = 1;
% bestNumNeighborCity = 1;
% 
% for numNeigbhbor=16:22
%     disp(['checking: ', num2str(numNeigbhbor)])
%     mdlCityCode.NumNeighbors = numNeigbhbor;
%     currentLossCity = kfoldLoss(crossval(mdlCityCode,'kfold',10));
%     if currentLossCity < bestLossCity
%         bestLossCity = currentLossCity
%         bestNumNeighborCity = numNeigbhbor
%     end   
% end
%         
% 
% % update with best Neighbor
% 
% mdlCountryCode = ClassificationKNN.fit(Training.X, Training.trainResult(:,2),'NSMethod','exhaustive',...
%     'Distance','cosine');
% mdlCountryCode.NumNeighbors = bestNumNeighborCountry;
% 
% mdlCityCode = ClassificationKNN.fit(Training.X, Training.trainResult(:,1),'NSMethod','exhaustive',...
%     'Distance','cosine');
% mdlCityCode.NumNeighbors = bestNumNeighborCity;
% 
% 
% 
% %% predict
% countryCodeTrain = predict(mdlCountryCode, Validation.X_val);
% cityCodeTrain = predict(mdlCityCode, Validation.X_val);
% countryCodeTest = predict(mdlCountryCode, Testing.X_test);
% cityCodeTest = predict(mdlCityCode, Testing.X_test);
% 
% %% save
% writeOutput('./result/validation_predicted.txt',cityCodeTrain,countryCodeTrain)
% writeOutput('./result/testing_predicted.txt',cityCodeTest,countryCodeTest)

