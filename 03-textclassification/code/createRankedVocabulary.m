function [ranked_Vocabulary, ranked_Vocabulary_Frequencies] = createRankedVocabulary(words)

% our vocabulary %
% which word has which frequency ( index contains pointers to the corresponding word in vocabulary for each running word in words. 
[vocabulary,~,index] = unique(words);
frequencies = hist(index,length(vocabulary));

% sort 
[ranked_Vocabulary_Frequencies,ranking_index] = sort(frequencies,'descend');
ranked_Vocabulary = vocabulary(ranking_index);

end