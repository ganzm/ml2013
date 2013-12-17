function data =  updateTypos(data, Global)
typoList = Global.TypoList;
vocabList = Global.Ranked_Vocabulary;


for i=1:length(data)
    splited = strsplit(data{i});
    for j=1:length(splited)
        word = splited{j};
        index = strcmp(vocabList, word);
        newWord = typoList{index};
        if(isempty(newWord));
           splited{j} = word;
        else
           splited{j} = newWord;
        end
    end
    data{i} = strjoin(splited);
end


end

