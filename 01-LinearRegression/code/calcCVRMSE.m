function [ error ] = calcCVRMSE( X,Y,w )
    error = calcRMSE(X,Y,w)/mean(Y);
end

