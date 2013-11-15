%% Cross Validation for finding best C and gamma
bestcv = 0;
for log2c = 3:0.1:4 %-1:3,
  for log2g = 3:0.2:5 %-4:1,
    cmd = ['-w-1 5 -w1 1 -v 10 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    cv = svmtrain(Y_training, X_training, cmd);
    if (cv >= bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
  end
end


%% With contour Plot
%grid of parameters
folds = 5; 
[C,gamma] = meshgrid(2.8:0.05:3.2, 4.3:0.05:4.7); %(-5:2:15, -15:2:3); 
%# grid search, and cross-validation 
cv_acc = zeros(numel(C),1); 
d= 2;
for i=1:numel(C)   
     cmd = ['-w-1 5 -w1 1 -v 10 -c ', num2str(2^C(i)), ' -g ', num2str(2^gamma(i))];
    cv_acc(i) = svmtrain(Y_training, X_training, cmd);
end
%# pair (C,gamma) with best accuracy
[~,idx] = max(cv_acc); 
%# contour plot of paramter selection 
contour(C, gamma, reshape(cv_acc,size(C))), colorbar
hold on;
text(C(idx), gamma(idx), sprintf('Acc = %.2f %%',cv_acc(idx)), ...  
    'HorizontalAlign','left', 'VerticalAlign','top') 
plot(C(idx), gamma(idx), 'r+')
hold off 
xlabel('log_2(C)'), ylabel('log_2(\gamma)'), title('Cross-Validation Accuracy') 

% disp
disp(['we have Accuracy: ', num2str(cv_acc(idx)), '%'])
disp(['best LogC = ', num2str(C(idx)), ' best LogGamma = ', num2str(gamma(idx))])
disp(['best C = ', num2str(2^C(idx)), ' best Gamma = ', num2str(2^gamma(idx))])

%set
bestc = 2^C(idx); bestg = 2^gamma(idx);


%%Not finished ye
%% With 3d Plot
%grid of parameters
folds = 10; 
[C,gamma] = meshgrid(-5:0.5:15, -15:0.5:3); 
%# grid search, and cross-validation 
cv_acc = zeros(numel(C),1); 
d= 2;
bestcv = 0;
for i=1:numel(C)   
     cmd = ['-w-1 5 -w1 1 -v 10 -c ', num2str(2^C(i)), ' -g ', num2str(2^gamma(i))];
    cv_acc(i) = svmtrain(Y_training, X_training, cmd);
    cv = cv_acc(i);
    if (cv >= bestcv),
      bestcv = cv; bestc = C(i); bestg = gamma(i);
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', C(i), gamma(i), cv, bestc, bestg, bestcv);
end
% pair (C,gamma) with best accuracy
[~,idx] = max(cv_acc); 

%

% disp
disp(['we have Accuracy: ', num2str(cv_acc(idx)), '%'])
disp(['best LogC = ', num2str(C(idx)), ' best LogGamma = ', num2str(gamma(idx))])
disp(['best C = ', num2str(2^C(idx)), ' best Gamma = ', num2str(2^gamma(idx))])

%set
bestc = 2^C(idx); bestg = 2^gamma(idx);


%%
% ###################################################################
% cross validation scale 1
% This is the big scale (rough)
% ###################################################################
stepSize = 1;
log2c_list = -20:stepSize:20;
log2g_list = -20:stepSize:20;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 0;
for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        param = ['-q -v 3 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(Y_training, X_training, param);
        cvMatrix(i,j) = cv;
        if (cv >= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end
disp(['CV scale1: best log2c:',num2str(bestLog2c),' best log2g:',num2str(bestLog2g),' accuracy:',num2str(bestcv),'%']);

% Plot the results
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick',1:numLog2g)
set(gca,'XTickLabel',sprintf('%3.1f|',log2g_list))
xlabel('Log_2\gamma');
set(gca,'YTick',1:numLog2c)
set(gca,'YTickLabel',sprintf('%3.1f|',log2c_list))
ylabel('Log_2c');

%%
% ###################################################################
% cross validation scale 2
% This is the medium scale
% ###################################################################
prevStepSize = stepSize;
stepSize = prevStepSize/2;
log2c_list = bestLog2c-prevStepSize:stepSize:bestLog2c+prevStepSize;
log2g_list = bestLog2g-prevStepSize:stepSize:bestLog2g+prevStepSize;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 0;
for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        % -v 3 --> 3-fold cross validation
        param = ['-q -v 3 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(Y_training, X_training, param);
        cvMatrix(i,j) = cv;
        if (cv >= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end

disp(['CV scale2: best log2c:',num2str(bestLog2c),' best log2g:',num2str(bestLog2g),' accuracy:',num2str(bestcv),'%']);

% Plot the results
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick',1:numLog2g)
set(gca,'XTickLabel',sprintf('%3.1f|',log2g_list))
xlabel('Log_2\gamma');
set(gca,'YTick',1:numLog2c)
set(gca,'YTickLabel',sprintf('%3.1f|',log2c_list))
ylabel('Log_2c');

%%
% ###################################################################
% cross validation scale 3
% This is the small scale
% ###################################################################
prevStepSize = stepSize;
stepSize = prevStepSize/2;
log2c_list = bestLog2c-prevStepSize:stepSize:bestLog2c+prevStepSize;
log2g_list = bestLog2g-prevStepSize:stepSize:bestLog2g+prevStepSize;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 0;
for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        % -v 3 --> 3-fold cross validation
        param = ['-q -v 3 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(Y_training, X_training, param);
        cvMatrix(i,j) = cv;
        if (cv >= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end

disp(['CV scale3: best log2c:',num2str(bestLog2c),' best log2g:',num2str(bestLog2g),' accuracy:',num2str(bestcv),'%']);

% Plot the results
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick',1:numLog2g)
set(gca,'XTickLabel',sprintf('%3.1f|',log2g_list))
xlabel('Log_2\gamma');
set(gca,'YTick',1:numLog2c)
set(gca,'YTickLabel',sprintf('%3.1f|',log2c_list))
ylabel('Log_2c');

