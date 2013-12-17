function data =  updateStemming(data, Global)
stemmList = Global.StemmList;
vocabList = Global.Ranked_Vocabulary;


for i=1:length(data)
    splited = strsplit(data{i});
    for j=1:length(splited)
        word = splited{j};
        index = strcmp(vocabList, word);
        newWord = stemmList{index};
        if(isempty(newWord));
           splited{j} = word;
        else
           splited{j} = newWord;
        end
    end
    data{i} = strjoin(splited);
end


end

