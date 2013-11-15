%% clean up & set up
clear
close all
clc
addpath('../../toolbox/libsvm-3.17/matlab/');
%% load from libSvm
[Y_training, X_training] = libsvmread('disease.train');

bestc = 4.9246;
bestg = 24.2515;

%% Do svmtrain with best coefficiants
%cmdBest = ['-w1 1 -w-1 5 -c ', num2str(bestc), ' -g ', num2str(bestg)];


cmdBest = ['-t 1 -d 20'];
model = svmtrain(Y_training, X_training, cmdBest);


%% svmtoy
svmtoy(Y_training, X_training, model, cmdBest);


