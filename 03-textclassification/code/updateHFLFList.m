function data =  updateHFLFList(data, Global)
HFLFList = Global.HFLFList;
vocabList = Global.Ranked_Vocabulary;


for i=1:length(data)
    splited = strsplit(data{i});
    counter = 1;
    splitednew = cell(0,0);
    for j=1:length(splited)
        word = splited{j};
        index = find(strcmp(vocabList, word));
        delete = HFLFList(index);
        if(delete);
           continue;
        else
           splitednew{counter} = word;
           counter = counter+1;
        end
    end
    data{i} = strjoin(splitednew);
end


end

