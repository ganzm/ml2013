function [ groups ] = groupBy( x )
%GROUPBY Summary of this function goes here
%   Detailed explanation goes here

x_sorted = sort(x);

[n, ~] = size(x);

current = intmin;
resultIndex = 1;

for i=1:n
    if x_sorted(i) ~= current
        groups(resultIndex) = x_sorted(i); 
        resultIndex = resultIndex + 1;
    end
    
    current = x_sorted(i);
end

