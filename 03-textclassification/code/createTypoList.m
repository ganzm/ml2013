function TypoList = createTypoList(Global)
ranked_Vocab = Global.Ranked_Vocabulary;
ranked_Vocab_Freq = Global.Ranked_Vocabulary_Frequencies;
TypoList = cell(size(ranked_Vocab));

%[~,indexForFirstMinValue] = min(ranked_Vocab_Freq);
%indexForFirstMinValue = find(ranked_Vocab_Freq == 10, 1);
indexForFirstMinValue = find((ranked_Vocab_Freq/sum(ranked_Vocab_Freq)) <0.001, 1);

TypoList(1:indexForFirstMinValue-1) = ranked_Vocab(1:indexForFirstMinValue-1);

wordlistWithFrequencyMoreThanOne = ranked_Vocab(1:indexForFirstMinValue-1);
wordlistWithFrequencyOne = ranked_Vocab(indexForFirstMinValue:end);

for currentWordIndex = 1:size(wordlistWithFrequencyOne,2)
   currentWord = wordlistWithFrequencyOne{currentWordIndex};
   
   tresh = calcTresh(currentWord);
   if(tresh == 0)
       continue
   end
   for wordToCheck = 1:size(wordlistWithFrequencyMoreThanOne,2)
       if (edit_distance_levenshtein(wordlistWithFrequencyMoreThanOne{wordToCheck}, currentWord) <= tresh)              
          
           TypoList{indexForFirstMinValue-1+currentWordIndex} = wordlistWithFrequencyMoreThanOne{wordToCheck};
           disp(['changed ', currentWord, ' to ', wordlistWithFrequencyMoreThanOne{wordToCheck}])
           break;
       end
    
   end
end
end

function tresh = calcTresh(word)

wordlength = length(word);

% % softer thresh
% if(wordlength >= 10)
%      tresh = 2;
% elseif(wordlength >= 5)
%     tresh = 1;
% elseif(wordlength >= 1)
%     tresh = 0;
% end

% % sandros whishes thresh
% if(wordlength >= 20)
%     tresh = 3;
% elseif(wordlength >= 10)
%     tresh = 2;
% elseif(wordlength >= 4)
%     tresh = 1;
% elseif(wordlength >= 1)
%     tresh = 0;
% end


% % f?rd 1er
% if(wordlength >= 10)
%     tresh = 3;
% elseif(wordlength >= 5)
%     tresh = 2;
% elseif(wordlength >= 2)
%     tresh = 1;
% elseif(wordlength >= 1)
%     tresh = 0;
% end

%higher thresh
if(wordlength >= 15)
    tresh = 4;
elseif(wordlength >= 10)
    tresh = 3;
elseif(wordlength >= 6)
    tresh = 2;
elseif(wordlength >= 4)
    tresh = 1;
elseif(wordlength >= 1)
    tresh = 0;
end

end
