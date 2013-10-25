function [X,bestErrorSoFar, bestWSoFar, denormParamY] = ForwardLearning(varargin)
threshold = varargin{1};
threshold2 = varargin{2};

trainingData = csvread('../testdata/training.csv');

Ynorm = normalize(trainingData(:,15));
Y = trainingData(:,15);

Xraw = trainingData(:,1:14);

%  x1    0.0043  Rank 12
%  x2    0.0306  Rank 10
%  x3    0.1390  Rank 5
%  x4    0.0042  Rank 13
%  x5    0.1696  Rank 3
%  x6    0.0463  Rank 7
%  x7    0.0243  Rank 11
%  x8    0.1204  Rank 6
%  x9    0.0394  Rank 8
%  x10   0.1451  Rank 4
%  x11   0.0362  Rank 9
%  x12   0.0002  Rank 14
%  x13   0.6762  Rank 1
%  x14   0.3137  Rank 2

    %ordering
    Xraw = [Xraw(:,13), Xraw(:,14), Xraw(:,5), Xraw(:,10), Xraw(:,3),... 
    Xraw(:,8), Xraw(:,6), Xraw(:,9), Xraw(:,11), Xraw(:,2), Xraw(:,7), ...
    Xraw(:,1),Xraw(:,4), Xraw(:,12)];
 

if nargin == 2 
    %good starting X    -> 0.1731
    X          = Xraw(:,1);
    X(:,end+1) = Xraw(:,1).^2;
    X(:,end+1) = sqrt(Xraw(:,1));
    X(:,end+1) = log2(Xraw(:,1));
    
    X(:,end+1) = Xraw(:,1).*Xraw(:,2);
    X(:,end+1) = (Xraw(:,1).^2).*Xraw(:,2);
    X(:,end+1) = (Xraw(:,1).^3).*Xraw(:,2);
    X(:,end+1) = (Xraw(:,1).^4).*Xraw(:,2);
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,2));
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,2));
   
    X(:,end+1) = Xraw(:,1).*Xraw(:,3);
    X(:,end+1) = (Xraw(:,1).^2).*Xraw(:,3);
    X(:,end+1) = (Xraw(:,1).^3).*Xraw(:,3);
    X(:,end+1) = (Xraw(:,1).^4).*Xraw(:,3);
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,3));
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,3));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,4));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,4));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,5));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,5));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,6));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,6));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,7));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,7));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,8));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,8));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,9));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,9));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,10));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,10));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,11));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,11));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,12));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,12));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,13));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,13));
    
    X(:,end+1) = log2(Xraw(:,1).*Xraw(:,14));
    X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,14));
    
    %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,2);
    X(:,end+1) = Xraw(:,2).^2;
    
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,3));
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,3));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,4));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,4));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,5));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,5));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,6));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,6));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,7));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,7));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,8));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,8));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,9));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,9));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,10));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,10));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,11));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,11));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,12));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,12));

    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,13));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,13));
    
    X(:,end+1) = log2(Xraw(:,2).*Xraw(:,14));
    X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,14));
     
    %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,3);
    X(:,end+1) = Xraw(:,3).^2;
    
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,4);
    X(:,end+1) = Xraw(:,4).^2;
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,5);
    X(:,end+1) = Xraw(:,5).^2;
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,6);
    X(:,end+1) = Xraw(:,6).^2;

     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,7);
    X(:,end+1) = Xraw(:,7).^2;
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,8);
    X(:,end+1) = Xraw(:,8).^2;
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,9);
    X(:,end+1) = Xraw(:,9).^2;
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,10);
    X(:,end+1) = Xraw(:,10).^2;
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,11);
    X(:,end+1) = Xraw(:,11).^2;
    
    %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,12);
    X(:,end+1) = Xraw(:,12).^2;
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,13);
    X(:,end+1) = Xraw(:,13).^2;
    
     %%%%%%%%%%%%%%%%%
    X(:,end+1) = Xraw(:,14);
    X(:,end+1) = Xraw(:,14).^2;
else
    X = varargin{2};
end

bestErrorSoFar = learnFunction(X,Y) 


    
for first = 1:6 %1:size(Xraw,2)
    disp(['stay tuned first: ', num2str(first), ' of: ', num2str(size(Xraw,2))])
    for second = 2:14%1:size(Xraw,2)
    disp(['stay tuned second: ', num2str(second), ' of: ', num2str(size(Xraw,2))])
    for powerFirst = 1:3 %1:3
    for powerSecond = 0:2 %0:2
    tz = (Xraw(:,first).^powerFirst) .* Xraw(:,second).^powerSecond;
   %tzz = [ty, tz, tz.^2, tz.^3, tz.^4, sqrt(tz), log2(tz)];
   % tzz = [Ynorm, tz, tz.^2, tz.^3, tz.^4, tz.^5, tz.^6, sqrt(tz), log2(tz)];
    tzz = [Ynorm, tz, sqrt(tz), log2(tz)];
    
    tcorr = corr(tzz, tzz);
    tc = tcorr(:,1)';
    tc = abs(tc(:,2:end));

    for index=1:length(tc)
    value= tc(index);
        if value > threshold
           Xtmp = [X, zeros(size((Xraw),1),1)];
               switch index
                   case 1
                       Xtmp(:,end) = ((Xraw(:,first).^powerFirst).*(Xraw(:,second)).^powerSecond);
%                    case 2
%                        Xtmp(:,end) = ((Xraw(:,first).^powerFirst).*(Xraw(:,second)).^powerSecond).^2;
%                    case 3
%                        Xtmp(:,end) = ((Xraw(:,first).^powerFirst).*(Xraw(:,second)).^powerSecond).^3;
%                    case 4
%                        Xtmp(:,end) = ((Xraw(:,first).^powerFirst).*(Xraw(:,second)).^powerSecond).^4;
%                    case 5
%                        Xtmp(:,end) = ((Xraw(:,first).^powerFirst).*(Xraw(:,second)).^powerSecond).^5;
%                    case 6
%                        Xtmp(:,end) = ((Xraw(:,first).^powerFirst).*(Xraw(:,second)).^powerSecond).^6;
                   case 2
                       Xtmp(:,end) = sqrt((Xraw(:,first).^powerFirst).*(Xraw(:,second)).^powerSecond);
                   case 3
                       Xtmp(:,end) = log2((Xraw(:,first).^powerFirst).*(Xraw(:,second)).^powerSecond);
                   otherwise
          
               
           end
         
            
            [errorTmp, bestWTmp, denormParamY] = learnFunction(Xtmp,Y);
            if(bestErrorSoFar-errorTmp > threshold2)
               disp(['Mind Blowing diff of:', num2str(bestErrorSoFar-errorTmp)])   
               switch index
                case 1
                    disp(['X(:,end+1) = (Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),');%',num2str(value)])
%               case 2
%                   disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),')).^2;%',num2str(value)])
%                 case 3
%                     disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),')).^3;%',num2str(value)])
%                 case 4
%                     disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),')).^4;%',num2str(value)])
%                 case 5
%                     disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),')).^5;%',num2str(value)])
%                 case 6
%                     disp(['X(:,end+1) = ((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),')).^6;%',num2str(value)])
                case 2
                    disp(['X(:,end+1) = sqrt((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),'));%',num2str(value)])
                case 3
                    disp(['X(:,end+1) = log2((Xraw(:,',num2str(first),').^',num2str(powerFirst),').*(Xraw(:,',num2str(second),').^',num2str(powerSecond),'));%',num2str(value)])
                otherwise  
            end
            end
            
            if bestErrorSoFar-errorTmp > threshold2 %we have a better soution now!!
            X = Xtmp;
            bestErrorSoFar = errorTmp;
            bestWSoFar = bestWTmp;
            end
            
        end
    end 
    end
    end
    end
end

   

end

