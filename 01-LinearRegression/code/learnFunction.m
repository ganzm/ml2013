function[bestCVRMSE, bestW, denormParamY] = learnFunction(X,Y)

[n, ~] = size(X);

%% normailzation
[Xnorm, ~] = normalize(X);
[Ynorm, denormParamY] = normalize(Y);
  	
%Xnorm = [ones(size(Xnorm,1),1),Xnorm];

%% perform crossvalidation
kValues = logspace(-6, 2, 50); % hyper parameter
meanErrs = zeros(size(kValues));

for i=1:size(kValues,2)
    [meanErrs(i), ~, ~] = crossvalidation(Xnorm, Ynorm, kValues(i));
end


%% Find best parameters
[~, minIndex] = min(meanErrs);
bestK = kValues(minIndex);
[bestW, ~] = trainData(Xnorm, Ynorm, bestK);

% estimate error CVRMSE
Y_trainresult = Xnorm * bestW;
Y_trainresult = denormalize(Y_trainresult, denormParamY);

sse = sum((Y - Y_trainresult).^2); % sum square error
rmse = sqrt(sse / n); % root mean square error
bestCVRMSE = rmse / mean(Y);    % CV(RMSE)

end