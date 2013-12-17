function StemmList = createStemmList(Global)
ranked_Vocab = Global.Ranked_Vocabulary;
StemmList = cell(size(ranked_Vocab));

for currentWordIndex = 1:size(ranked_Vocab,2)-1
   currentWord = ranked_Vocab{currentWordIndex};
   lengthCurrentWord = length(currentWord);
   if lengthCurrentWord < 4%4
       continue
   end
   
   for wordToCheckIndex = currentWordIndex+1:size(ranked_Vocab,2)
       wordToCheck = ranked_Vocab{wordToCheckIndex};
       
       if length(wordToCheck) < 4%4
          continue 
       end
       
       %check stemm
       [frac,stemmWord] = edit_distance_stemm(wordToCheck, currentWord);
       
       % tresh = calcTresh(currentWord); think about
       if ( frac >= 0.7)  %0.8            
           StemmList{currentWordIndex} = stemmWord;
           StemmList{wordToCheckIndex} = stemmWord;
           disp(['changed ', currentWord, ' and ', wordToCheck, ' to ', stemmWord])
           break;
       end
    
   end
end
end

function [frac,stemmWord] = edit_distance_stemm(wordToCheck, currentWord)
lengthWordToCheck = length(wordToCheck);
lengthCurrentWord = length(currentWord);

lengthSmallerWord = min(lengthWordToCheck,lengthCurrentWord);
lengthLargerWord = max(lengthWordToCheck,lengthCurrentWord);
counter = 0;
for i = 1:lengthSmallerWord
      if wordToCheck(i)==currentWord(i)
          counter = counter + 1;
      else
          break
      end 
end

frac = counter/lengthLargerWord;
stemmWord = wordToCheck(1:counter);
end
