function [ scaledX ] = scale(X)

[n, ~] = size(X);

minElements = repmat(min(X), n, 1);
maxElements = repmat(max(X), n, 1);
scaledX = (X - minElements) ./ (maxElements -minElements);

end

