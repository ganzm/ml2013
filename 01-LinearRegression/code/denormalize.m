function [ denormalizedData ] = denormalize( data, param )
    [nSamples, ~] = size(data);

    dMean = repmat(param.mean, nSamples, 1);
    dVar = repmat(param.var, nSamples, 1);

    denormalizedData = (data.*dVar)+dMean;

end

