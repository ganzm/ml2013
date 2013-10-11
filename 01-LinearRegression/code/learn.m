% this file may be renamed


 
trainingdata = '../testdata/training.csv';
%LEARN Summary of this function goes here
%   Detailed explanation goes here

disp(['learning from ' trainingdata]);


% read raw csv data
data = csvread(trainingdata);
[nSamples, nColumns] = size(data);

% normalize data
dMean = repmat(mean(data), nSamples, 1);
dVar = repmat(var(data), nSamples, 1);

normalizedData = (data - dMean) ./ dVar;

% split them
result = data(:,15);
features = data(:,1:14);


% logarithmic features
% column 8 to 13 are numbers to the power of 2

% result varies by 10^x
result = log(result);






