function [ normalizedData, param] = normalize( data )
    [nSamples, ~] = size(data);
    
    param.mean = mean(data);
    param.var = var(data);

    dMean = repmat(param.mean, nSamples, 1);
    dVar = repmat(param.var, nSamples, 1);

    normalizedData = (data - dMean) ./ dVar;
end

