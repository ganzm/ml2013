function [ normalizedData, dMean, dVar ] = normalize( data )
    [nSamples, ~] = size(data);

    dMean = repmat(mean(data), nSamples, 1);
    dVar = repmat(var(data), nSamples, 1);

    normalizedData = (data - dMean) ./ dVar;
end

