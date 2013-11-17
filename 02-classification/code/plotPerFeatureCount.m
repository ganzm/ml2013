function [] = plotPerFeatureCount(X,Y)
X = full(X);

%X_meanIntensity = X(:,1:3:27);
%X_meanGradient = X(:,2:3:27);
%X_varianceGradient = X(:,3:3:27);

%AllFeatures3D = zeros(965,9,3);
%AllFeatures3D(:,:,1) = X_meanIntensity;
%AllFeatures3D(:,:,2) = X_meanGradient;
%AllFeatures3D(:,:,3) = X_varianceGradient;

histSize=10;

    
for currentFeature = 1:size(X,2)
    figure(currentFeature);
    subplot(1,3,1)
    [bincounts] = histc(X(Y==-1,currentFeature), 0:0.1:0.9);
    bar(0:0.1:0.9,bincounts,'histc')
    title(['feature No: ', num2str(currentFeature), ' diseased']);
    
    subplot(1,3,2)
    [bincounts] = histc(X(Y==1,currentFeature), 0:0.1:0.9);
    bar(0:0.1:0.9,bincounts,'histc')
    title(['feature No: ', num2str(currentFeature), ' normal']);
    
    
    subplot(1,3,3)
    [bincountsDiseased] = histc(X(Y==-1,currentFeature), 0:0.1:0.9);
    [bincountsNormal] = histc(X(Y==1,currentFeature), 0:0.1:0.9);
    bar(0:0.1:0.9,[bincountsDiseased, bincountsNormal], 'histc')    
    title(['feature No: ', num2str(currentFeature), ' combined (left = disease)']);
    

end

    %Sum
%     X_meanIntensitySum = sum(X_meanIntensity,2);
%     X_meanGradientSum = sum(X_meanGradient,2);
%     X_varianceGradientSum = sum(X_varianceGradient,2);
%     
%     figure(4)
%     [diseaseCount,~] = hist(X_meanIntensitySum(Y==-1,:), histSize);
%     [normalCount,~] = hist(X_meanIntensitySum(Y==1,:), histSize);
%     histmat = [diseaseCount', normalCount'];
%     bar(histmat);
%     
%     figure(5)
%     [diseaseCount,~] = hist(X_meanGradientSum(Y==-1,:), histSize);
%     [normalCount,~] = hist(X_meanGradientSum(Y==1,:), histSize);
%     histmat = [diseaseCount', normalCount'];
%     bar(histmat);
%     
%     figure(6)
%     [diseaseCount,~] = hist(X_varianceGradientSum(Y==-1,:), histSize);
%     [normalCount,~] = hist(X_varianceGradientSum(Y==1,:), histSize);
%     histmat = [diseaseCount', normalCount'];
%     bar(histmat);
% 


end