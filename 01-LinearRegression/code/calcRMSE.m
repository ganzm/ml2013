function [ error ] = calcRMSE( X,Y,w )
    sse = sum((Y -  (w' * X')').^2); % sum square error
    error = sqrt(sse /size(Y,1)); % root mean square error
end

