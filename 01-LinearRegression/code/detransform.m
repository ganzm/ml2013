function [ Y ] = detransform( Y_trans, parameter )

    [nSamples, ~] = size(Y_trans);
    
    dMean = repmat(parameter.mean, nSamples, 1);
    dVar = repmat(parameter.var, nSamples, 1);

    Y = Y_trans .* dVar + dMean;
    
    % dont do any transformation
    %Y = Y_trans;
end

