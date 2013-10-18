function [ normalizedData, param] = normalize( data )
    [nSamples, ~] = size(data);
    
    param.mean = mean(data);
    param.std = std(data);

    dMean = repmat(param.mean, nSamples, 1);
    dStd = repmat(param.std, nSamples, 1);

    normalizedData = (data - dMean) ./ dStd;
end

