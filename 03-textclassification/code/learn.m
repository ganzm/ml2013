
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




% %% reshape them
% X = trainingData(:,1:27);
% labels = trainingData(:,28);
% 
% Xt = testingData;
% Xv = validationData;
% 
% %% plot two features
% normal = X(labels== 1,:);
% dis = X(labels == -1,:);
% 
% for j=1:27    
%     [xN, ~] = size(normal);
%     [xD, ~] = size(dis);
%     numFeatures = max(xN, xD);
%     tmp = zeros(numFeatures,2);
%     tmp(1:xN,1) = normal(:,j);
%     tmp(1:xD,2) = dis(:,j);
%     
%     figure;
%     scale = linspace(min(min(tmp)), max(max(tmp)), 40);
%     hist(tmp, scale);
%     title(['Histogram Feature ' num2str(j) ]);
% end
% 
% %% learn
% 
% SVMStruct = svmtrain(X, labels, 'autoscale', true, 'kernel_function', 'rbf', 'rbf_sigma', 0.5);
% 
% Y = svmclassify(SVMStruct,X);
% Yt = svmclassify(SVMStruct,Xt);
% Yv = svmclassify(SVMStruct,Xv);
% 
% %% estimate error
% 
% 
% %% write output
% writeOutput('validation.csv', Yv);
% writeOutput('testing.csv', Yt);
