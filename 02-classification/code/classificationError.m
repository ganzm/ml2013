function [ ce, nFP, nFN, FP, FN] = classificationError( Y_predicted, Y_real )
    ce = 0;
    nFP = 0;
    nFN = 0;
    FP = [];
    FN = [];
    for i=1:length(Y_predicted)
        
       % falce negative or false positive
       if Y_predicted(i) ~= Y_real(i)
           if Y_predicted(i) == 1
               ce = ce + 5;
               nFP = nFP + 1;
               FP = [FP, i];
           else
               ce = ce + 1; 
               nFN = nFN + 1;
               FN = [FN, i];
           end
       end
    end
    ce = ce / length(Y_predicted);
end

