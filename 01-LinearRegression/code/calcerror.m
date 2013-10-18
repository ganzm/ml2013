function [ error ] = calcerror( X,Y,w )
    sse = sum((Y -  (w' * X')').^2); % sum square error
    rmse = sqrt(sse /size(Y,1)); % root mean square error
    error = rmse / mean(Y); % CV(RMSE)
    error=rmse; %change here for other errors
end

