function [ Y_trans, parameter ] = transform( Y )

    [nSamples, ~] = size(Y);

    parameter.mean = mean(Y);
    parameter.var = var(Y);
    
    dMean = repmat(parameter.mean, nSamples, 1);
    dVar = repmat(parameter.var, nSamples, 1);

    normalizedData = (Y - dMean) ./ dVar;
    
    Y_trans = normalizedData;
    
    % dont do any transformation
    %Y_trans = Y;
end

