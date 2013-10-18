function [ denormalizedData ] = denormalize( data, param )
    [nSamples, ~] = size(data);

    dMean = repmat(param.mean, nSamples, 1);
    dStd = repmat(param.std, nSamples, 1);

    denormalizedData = (data.*dStd)+dMean;

end

