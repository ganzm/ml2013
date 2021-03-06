function [ bagOfSimilarWords ] = createBagOfSimilarWords( bagOfWords )
%CREATEBAGOFSIMILARWORDS Summary of this function goes here
%   Detailed explanation goes here



b = cell(0,0);

% loop through unique words and try to assign it to a set of similar words
for i=1:length(bagOfWords)
    
    % word to add
    word = bagOfWords{i};
    wordInserted = false;
    thresh = calcTresh(word);
    
    disp(['Bag of Similar Words ' num2str(i) '/' num2str(length(bagOfWords)) ' ' word ]);
    
    % loop through list of similar word-lists
    for j=length(b):-1:1
       
        similarWordCell = b{j};
        
        % loop through list of similar words
        %for k=1:length(similarWordCell)
        for k=1:1
            if edit_distance_levenshtein(similarWordCell{k}, word) < thresh                
                similarWordCell{length(similarWordCell) + 1} = word;
                b{j} = similarWordCell;
                wordInserted = true;
                break;  
            end
        end
    end
    
    if wordInserted == false
        
        newSimilarWordCell = cell(1,1);
        newSimilarWordCell{1} = word;
        
        b{length(b)+1} = newSimilarWordCell;
    end
end

bagOfSimilarWords = b;

end

function tresh = calcTresh(word)
wordlength = length(word);

% if(wordlength >= 7)
%     tresh = 3;
% elseif(wordlength >= 5)
%     tresh = 2;
% elseif(wordlength >= 3)
%     tresh = 1;
% elseif(wordlength >= 1)
%     tresh = 0;
% end

if(wordlength >= 15)
    tresh = 2;
elseif(wordlength >= 10)
    tresh = 1;
elseif(wordlength >= 1)
    tresh = 0;
end


end

