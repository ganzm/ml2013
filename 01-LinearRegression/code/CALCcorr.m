function [  ] = CALCcorr( threshold )
%%
trainingData = csvread('../testdata/training.csv');
ty = normalize(trainingData(:,15));

%trainingData(:, 8:9) = log2(trainingData(:,8:9));
%trainingData(:, 11:13) = log2(trainingData(:,11:13));


for first = 1:14
    for second = 1:14
    for powerFirst = 1:3
    for powerSecond = 0:2
    tz = (trainingData(:,first).^powerFirst) .* trainingData(:,second).^powerSecond;
   % tzz = [ty, tz, tz.^2, tz.^3, tz.^4, sqrt(tz), log2(tz)];
    tzz = [ty, tz, tz.^2, tz.^3, tz.^4, tz.^5, tz.^6, sqrt(tz), log2(tz)];
    
    tcorr = corr(tzz, tzz);
    tc = tcorr(:,1)';
    tc = abs(tc(:,2:end));

    for index=1:length(tc)
    value= tc(index);
        if value > threshold
            switch index
                case 1
                    disp(['X(:,end+1) = (Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),');%',num2str(value)])
                case 2
                    disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),') .^',num2str(powerSecond),')).^2;%',num2str(value)])
                case 3
                    disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),') .^',num2str(powerSecond),')).^3;%',num2str(value)])
                case 4
                    disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),') .^',num2str(powerSecond),')).^4;%',num2str(value)])
                case 5
                    disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),') .^',num2str(powerSecond),')).^5;%',num2str(value)])
                case 6
                    disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),') .^',num2str(powerSecond),')).^6;%',num2str(value)])
                case 7
                    disp(['X(:,end+1) = sqrt((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),') .^',num2str(powerSecond),'));%',num2str(value)])
                case 8
                    disp(['X(:,end+1) = log2((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),') .^',num2str(powerSecond),'));%',num2str(value)])
                otherwise  
            end
        end
    end 
    end
    end
    end
end


end

