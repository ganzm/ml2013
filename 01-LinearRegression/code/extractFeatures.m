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
function [ X ] = extractFeatures( Xraw )
    X = Xraw;
    % transform them to log2 values
    X(:, 8:9) = log2(X(:,8:9));
    X(:, 11:13) = log2(X(:,11:13));
    
    % add some empirical good polynomial features (x1*x2, x2*x3, etc.)
    X(:, 15) = X(:,9).*X(:,14);
    X(:, 16) = X(:,13).*X(:,14);
  
    
end

