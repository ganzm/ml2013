function [ ce, nWrongMatches ] = classificationError( Y_predicted, Y_real )
    ce = 0;
    for i=1:length(Y_predicted)
        
       % falce negative or false positive
       if Y_predicted(i) ~= Y_real(i)
           if Y_predicted(i) == 1
               ce = ce + 5;
           else
               ce = ce + 1; 
           end
       end
    end
    ce = ce / length(Y_predicted);
    nWrongMatches = sum(Y_predicted ~= Y_real);
end

