% Input:
%   data        - a m x n matrix where each row corresponds to one
%                 observation. The last column is expected to be the
%                 result.
% Output:
%   X           - a matrix containing all features
%   Y           - a column vector containing the result
function [ X, Y ] = extractFeatures( data )
    X = data(:,1:14);
    Y = data(:,15);
end

