function dictionary = createRankedDictionary(trainResult)

[dictionary_unranked, ~, indexOfDic] = unique(sort(trainResult),'rows');

rankingOfDic = histc(indexOfDic,1:size(dictionary_unranked,1));
all = sort([dictionary_unranked, rankingOfDic]);

while(size(all,1) > size(unique(trainResult(:,1)),1))
    for i = 1:size(all,1)
       cityTocheck = all(i,1); 
       numbersOfCity = length(all(all(:,1)==cityTocheck));
       if(numbersOfCity ~= 1)
           all(i,:) = [];  
           break
       end
    end
end
 dictionary = all(:,1:2);

end