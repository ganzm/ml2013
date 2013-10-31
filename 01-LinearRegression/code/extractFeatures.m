%  1 = Width 
%  2 = ROB size
%  3 = IQ size
%  4 = LSQ size
%  5 = RF sizes
%  6 = RF read ports 
%  7 = RF write ports 
%  8 = Gshare size 
%  9 = BTB size 
% 10 = Branches allowed 
% 11 = L1 Icache size 
% 12 = L1 Dcache size 
% 13 = L2 Ucache size 
% 14 = Depth
% 15 = Delay in microseconds (Output)
% Input:
%   data        - a m x n matrix where each row corresponds to one
%                 observation. The last column is expected to be the
%                 result.
% Output:
%   X           - a matrix containing all features
function [ X ] = extractFeatures( Xraw)

   % Xraw(:, 8:9) = log2(Xraw(:,8:9));
   % Xraw(:, 11:13) = log2(Xraw(:,11:13));
    
    
    %ordering
    Xraw = [Xraw(:,13), Xraw(:,14), Xraw(:,5), Xraw(:,10), Xraw(:,3),... 
    Xraw(:,8), Xraw(:,6), Xraw(:,9), Xraw(:,11), Xraw(:,2), Xraw(:,7), ...
    Xraw(:,1),Xraw(:,4), Xraw(:,12)];
    
    
 
    X = [];
   
    
%     X(:,end+1) = Xraw(:,1);
%     X(:,end+1) = Xraw(:,1).^2;
%     X(:,end+1) = sqrt(Xraw(:,1));
%     X(:,end+1) = log2(Xraw(:,1));
%     
%     X(:,end+1) = Xraw(:,1).*Xraw(:,2);
%     X(:,end+1) = (Xraw(:,1).^2).*Xraw(:,2);
%     X(:,end+1) = (Xraw(:,1).^3).*Xraw(:,2);
%     X(:,end+1) = (Xraw(:,1).^4).*Xraw(:,2);
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,2));
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,2));
%    
%     X(:,end+1) = Xraw(:,1).*Xraw(:,3);
%     X(:,end+1) = (Xraw(:,1).^2).*Xraw(:,3);
%     X(:,end+1) = (Xraw(:,1).^3).*Xraw(:,3);
%     X(:,end+1) = (Xraw(:,1).^4).*Xraw(:,3);
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,3));
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,3));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,4));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,4));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,5));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,5));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,6));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,6));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,7));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,7));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,8));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,8));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,9));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,9));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,10));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,10));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,11));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,11));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,12));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,12));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,13));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,13));
%     
%     X(:,end+1) = log2(Xraw(:,1).*Xraw(:,14));
%     X(:,end+1) = sqrt(Xraw(:,1).*Xraw(:,14));
%     
%     %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,2);
%     X(:,end+1) = Xraw(:,2).^2;
%     
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,3));
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,3));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,4));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,4));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,5));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,5));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,6));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,6));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,7));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,7));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,8));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,8));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,9));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,9));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,10));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,10));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,11));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,11));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,12));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,12));
% 
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,13));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,13));
%     
%     X(:,end+1) = log2(Xraw(:,2).*Xraw(:,14));
%     X(:,end+1) = sqrt(Xraw(:,2).*Xraw(:,14));
%      
%     %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,3);
%     X(:,end+1) = Xraw(:,3).^2;
%     
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,4);
%     X(:,end+1) = Xraw(:,4).^2;
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,5);
%     X(:,end+1) = Xraw(:,5).^2;
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,6);
%     X(:,end+1) = Xraw(:,6).^2;
% 
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,7);
%     X(:,end+1) = Xraw(:,7).^2;
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,8);
%     X(:,end+1) = Xraw(:,8).^2;
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,9);
%     X(:,end+1) = Xraw(:,9).^2;
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,10);
%     X(:,end+1) = Xraw(:,10).^2;
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,11);
%     X(:,end+1) = Xraw(:,11).^2;
%     
%     %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,12);
%     X(:,end+1) = Xraw(:,12).^2;
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,13);
%     X(:,end+1) = Xraw(:,13).^2;
%     
%      %%%%%%%%%%%%%%%%%
%     X(:,end+1) = Xraw(:,14);
%     X(:,end+1) = Xraw(:,14).^2;
%     
   
    fIdx1 = 1;
    fIdx2 = 2;
    grouped = groupBy(Xraw(:,fIdx1));
    [~,groupSize] = size(grouped);
    newFeatures = [];
    for groupIndex=1:groupSize
        temp = grouped(groupIndex);
        
        newFeature = Xraw(:,fIdx2);
        newFeature(Xraw(:,fIdx1) ~= temp) = 0;
       
        newFeatures = [newFeatures, newFeature];
    end
    
    
    X = [X,newFeatures(:,1)+newFeatures(:,2)+newFeatures(:,3)];
    X = [X,newFeatures(:,4)+newFeatures(:,5)];
    
   
   
    
end

