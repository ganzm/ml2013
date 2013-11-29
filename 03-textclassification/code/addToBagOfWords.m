function [ newBagOfWords ] = addToBagOfWords( bagOfWords, data)
%ADDTOBAGOFWORDS Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(data)
    splited = strsplit(data{i});
    for j=1:length(splited)
        s = splited{j}; 
        bagOfWords{length(bagOfWords)+1}  = s;
    end
end

newBagOfWords = bagOfWords;
end

