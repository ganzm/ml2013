%% read raw csv data
trainingData = csvread('../testdata/training.csv');
[n, nColumns] = size(trainingData);


%% split big Matrix and feature extraction on X
Y = trainingData(:,15);
% test if micro to second is a good idea
%Y = Y.*1e-6;

X = trainingData(:,1:14);
X = extractFeatures(X);

%% normailzation
[X, ~] = normalize(X);
%X = x2fx(X,'quadratic');
[Y, denormParamY] = normalize(Y);

%% add row with one 
X = [ones(size(X,1),1),X];

%% perform crossvalidation
%k = 0:1e-5:5e-3; % hyper parameter
k = 0:1e-5:1e-3;  % 0    0.00001    0.00002 till 0.0001

% the old way.. starting from 100, 100/2, etc.
% k = zeros(1,100);
% k(1)=100;
% for i=2:size(k,2)
%    k(i) = k(i-1)/2; 
% end

meanErrs = zeros(1,size(k,2));

for i=1:size(k,2)
    [meanErrs(i), ~, ~] = crossvalidation(X, Y, k(i));
end


%% Find best parameters
[minVal, minIndex] = min(meanErrs);
bestK = k(minIndex);
[bestW, bestError] = trainData(X, Y, bestK);

%plot k's vs errors (for finding out good k's)
figure
disp(['best K = ' num2str(bestK)])
disp(['best mean Error = ' num2str(minVal)])
disp(['bestError = ' num2str(bestError)])
plot(k,meanErrs, 'r+')

%% for testing only

Ylearn = (bestW'*X')';

Ylearn = denormalize(Ylearn,denormParamY);
Y = denormalize(Y,denormParamY);
disp(['we have ' num2str(size(Ylearn(Ylearn < 0),1)) ' negative values in Ylearn'])


%% compute results
computeResult(bestW, denormParamY, 0)
