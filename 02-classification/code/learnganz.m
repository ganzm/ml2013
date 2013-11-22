%function [] = learnganz()

%%
baseline_hard = 0.15825846579129232;
baseline_easy = 0.4277816171389081;
our_result = 0.147099;

result = (our_result - baseline_hard) / (baseline_easy-baseline_hard);
asdf = (1-result)*0.5  + 0.5;

%% read raw csv data
testingData = csvread('data/origin/testing.csv');
trainingData = csvread('data/origin/training.csv');
validationData = csvread('data/origin/validation.csv');

X = trainingData(:,1:27);
labels = trainingData(:,28);

Xt = testingData;
Xv = validationData;

%% plot two features
normal = X(labels== 1,:);
dis = X(labels == -1,:);

for j=1:27    
    [xN, ~] = size(normal);
    [xD, ~] = size(dis);
    numFeatures = max(xN, xD);
    tmp = zeros(numFeatures,2);
    tmp(1:xN,1) = normal(:,j);
    tmp(1:xD,2) = dis(:,j);
    
    figure;
    scale = linspace(min(min(tmp)), max(max(tmp)), 40);
    hist(tmp, scale);
    title(['Histogram Feature ' num2str(j) ]);
end

%% learn

SVMStruct = svmtrain(X, labels, 'autoscale', true, 'kernel_function', 'rbf', 'rbf_sigma', 0.5);

Y = svmclassify(SVMStruct,X);
Yt = svmclassify(SVMStruct,Xt);
Yv = svmclassify(SVMStruct,Xv);

%% estimate error


%% write output
writeOutput('validation.csv', Yv);
writeOutput('testing.csv', Yt);

%end