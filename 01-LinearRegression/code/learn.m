function [] = learn()

%% read raw csv data
testingData = csvread('../testdata/testing.csv');
trainingData = csvread('../testdata/training.csv');
validationData = csvread('../testdata/validation.csv');

% remove bad features
trainingData(187,:) = [];
trainingData(188,:) = [];

% extract data
Xraw = trainingData(:,1:14);
Y = trainingData(:,15);

% extract training set
x =  extractFeatures(Xraw);
% extract test set
xt =  extractFeatures(testingData);
% extract validation set
xv =  extractFeatures(validationData);

%% perform crossvalidation

kValues = logspace(-6, 2, 50); % hyper parameter
numX13 = size(x,2);
for j=1:numX13
    xj = x(:,j,:);
    xj = reshape(xj, size(xj,1),size(xj,3));
    Yj = Y;
    
    zeroIndices = (xj(:,1) == 0);
    xj(zeroIndices,:) = [];
    Yj(zeroIndices) = [];

    meanErrs = zeros(size(kValues));
    for i=1:size(kValues,2)
        [meanErrs(i), ~, ~] = crossvalidation(xj, Yj, kValues(i));
    end

    [~, bestKIndex] = min(meanErrs);
    [w, ~] = trainData(xj, Yj, kValues(bestKIndex));
    
    weight{j} = w;
end

Ytrain = estimateValues(x, weight);
Ytest = estimateValues(xt, weight);
Yvalidation = estimateValues(xv, weight);

%% caluculate CVRMSE
sse = sum((Y -  Ytrain).^2); % sum square error
error = sqrt(sse /size(Y,1)); % root mean square error
error = error/mean(Y);
    
disp(['CVRMSE: ' num2str(error)]);

writeOutput( 'testresult.csv', Ytest);
writeOutput( 'validationresult.csv', Yvalidation);

end

%% estimate Values
function [y] = estimateValues(x, w)

    y = zeros(size(x,1),1);

    for i = 1:size(x,2)
        xi = x(:,i,:);
        xi = reshape(xi, size(xi,1),size(xi,3));
        
        y = y + (xi * w{i});
    end
end

function [X] = extractFeatures(Xraw)
    X = [];
    
    group13 = groupBy(Xraw(:,13));
    for groupIndex=1:length(group13)
        temp = group13(groupIndex);
        newFeature = Xraw(:,14);

        featureMask = Xraw(:,13) ~= temp;
        
        % add basis feature
        newFeature(featureMask) = 0;
        X(:,groupIndex,1) = newFeature;
        
        % add other features
        X = addFeature(X, featureMask, groupIndex, Xraw(:,5) .* Xraw(:,10));
        X = addFeature(X, featureMask, groupIndex, Xraw(:,4) .* Xraw(:,10));
        
    end
end

function [X] =  addFeature(X, featureMask, groupIndex, Xnew)
    Xnew(featureMask) = 0;
    X(:,groupIndex,size(X,3)+1) = Xnew;  
end


