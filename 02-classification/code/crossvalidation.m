function [ bestc, bestg ] = crossvalidation(Y_training, X_training, plotResults)
first = true;
ultraBestCV = 0;
k=1;
while true

    if(first)
        first = false;
       
        % big
        stepSize = 5;
        log2c_list = -20:stepSize:20;
        log2g_list = -20:stepSize:20;
        
        %medium
        %stepSize = 2;
        %log2c_list = -4:stepSize:6;
        %log2g_list = -4:stepSize:6;
        
        % small
        %stepSize = 0.2;
        %log2c_list = 1.8:stepSize:3.2;
        %log2g_list = 4.3:stepSize:4.7;
    else
        prevStepSize = stepSize;
        stepSize = prevStepSize/2;
        %stepSize = prevStepSize/4;
        log2c_list = bestLog2c-prevStepSize:stepSize:bestLog2c+prevStepSize;
        log2g_list = bestLog2g-prevStepSize:stepSize:bestLog2g+prevStepSize;
    end
    
    numLog2c = length(log2c_list);
    numLog2g = length(log2g_list);
    cvMatrix = zeros(numLog2c,numLog2g);
    bestcv = 0;
    for i = 1:numLog2c
        log2c = log2c_list(i);
        for j = 1:numLog2g
            log2g = log2g_list(j);
            cmd = ['-q -w1 1 -w-1 5 -v 10 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
            cv = svmtrain(Y_training, X_training, cmd);
            cvMatrix(i,j) = cv;
            if (cv > bestcv),
                bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
            end
             fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestLog2c, bestLog2g, bestcv);
        end
    end
    disp(['CV scale1: best log2c:',num2str(bestLog2c),' best log2g:',num2str(bestLog2g),' accuracy:',num2str(bestcv),'%']);
    
    bestc = 2^bestLog2c;
    bestg = 2^bestLog2g;
    
    if plotResults
        % Plot the results
        figure(k);
        imagesc(cvMatrix); colormap('jet'); colorbar;
        set(gca,'XTick',1:numLog2g)
        set(gca,'XTickLabel',sprintf('%3.1f|',log2g_list))
        xlabel('Log_2\gamma');
        set(gca,'YTick',1:numLog2c)
        set(gca,'YTickLabel',sprintf('%3.1f|',log2c_list))
        ylabel('Log_2c');
    end
    
    if bestcv > ultraBestCV
        ultraBestCV = bestcv;
    else
        break
    end
        
    
    k=k+1;
    

end
end
