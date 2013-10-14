%% this file may be renamed

% Settings
testingdataPath = '../testdata/testing.csv';
trainingdataPath = '../testdata/training.csv';
validationdataPath = '../testdata/validation.csv';

outputfilePraefix = 'output-';
outputfilePostfix = '.txt';


%% read raw csv data
trainData = csvread(trainingdataPath);
testData = csvread(testingdataPath);
validationData = csvread(validationdataPath);

[n, nColumns] = size(trainingdata);

trainResult = trainData(:,15);
x = trainData(:, 1:14);

%% prepare feature vector

%% logarithmic features - column 8 to 13 are numbers to the power of 2
x(:,8) = log(x(:,8));
x(:,9) = log(x(:,9));
x(:,10) = log(x(:,10));
x(:,11) = log(x(:,11));
x(:,12) = log(x(:,12));
x(:,13) = log(x(:,13));

%% normalize data
dMean = repmat(mean(x), n, 1);
dVar = repmat(var(x), n, 1);

x = (x - dMean) ./ dVar;


%% perform crossvalidation

% todo vary parameters
err = 1;
disp(['Crossvalidation Error:' err]);


%% perform learning step with the whole training set

% todo optain w with dimensinality
w = rand(nColumns-1,1);

%% compute result
y = w'*x';



%% Write output file

path = [outputfilePraefix num2str(err) outputfilePostfix];
disp(['write result to ' path]);

result = y;

fileID = fopen(path, 'w');
for item = result
    fprintf(fileID,'%d\n', item);
end
fclose(fileID);





