%% clean up
clear
close all
clc

%% set up
addpath('../../toolbox/libsvm-3.17/matlab/');

%% read raw csv data
trainingDataRaw = csvread('training.csv');

%% split data
X_training = trainingDataRaw(:,1:end-1);
Y_training = trainingDataRaw(:,end);

%% scale training data and do the same for testing and validation (same scaling factor)
%minimums = min(X_training, [], 1);
%ranges = max(X_training, [], 1) - minimums;
%X_training = (X_training - repmat(minimums, size(X_training, 1), 1)) ./ repmat(ranges, size(X_training, 1), 1);


%% Feature manipulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%basic features max validation accuarcy: 91.637900
%X_training = X_training;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% only use the best max validation accuarcy: 70.283300
%X_training = X_training(:,[22,25]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% only use the good ones max validation accuarcy: 74.360700
%X_training = X_training(:,7:3:22);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% brut Force: Basics, square, cubic, log2, 1/X, one*another, max validation accuarcy: 91.154100
X_basic = X_training;
X_training = [X_basic, X_basic.^2, X_basic.^3, log2(X_basic), X_basic.^(-1)];%

for first=1:size(X_basic,2)-1
   for second=2:size(X_basic,2)
      X_training = [X_training, X_training(:,first).*X_training(:,second)]; 
   end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% sparse
X_training = sparse(X_training);



%% save
libsvmwrite('../toolbox/cmdData/disease.train.scale', Y_training, X_training);

