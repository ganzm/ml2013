function [ x_denormalized ] = denormalize( x, mean, var )
%DENORMALIZE Summary of this function goes here
%   Detailed explanation goes here

    x_denormalized = x .* var + mean;

end

