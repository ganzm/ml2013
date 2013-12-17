function [ x ] = createBooleanFeatures( xRaw, bagOfSimilarWords )
%CREATEBOOLEANFEATURES Summary of this function goes here
%   Detailed explanation goes here


numSamples = size(xRaw,2);
numFeatures = length(bagOfSimilarWords);

x = zeros(numSamples, numFeatures);

for i = 1:numSamples
    
    disp(['Create BoolFeatures ' num2str(i) '/' num2str(numSamples)]);
    
    % split each city name
    splited = strsplit(xRaw{i});
    
    for j=1:length(splited)
        s = splited{j};
        
        % find s in our bagOfSimilarWords
        found = false;
        for m=1:length(bagOfSimilarWords)
            similarWordSet = bagOfSimilarWords{m};
            %  for n=1:length(similarWordSet)
            % if strcmp(similarWordSet{n}, s)
            if strcmp(similarWordSet, s)
                
                %x(i, m) = 1; %
                x(i, m) = x(i, m) + 1;
                found = true;
                break;
            end
            %end
            
            if found
                break;
            end
        end
    end
end


end

