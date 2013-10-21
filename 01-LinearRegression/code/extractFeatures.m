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
    
    % add some empirical good polynomial features (x1*x2, x2*x3, etc.)
    X(:, 15) = X(:,9).*X(:,14);
    X(:, 16) = X(:,13).*X(:,14);
    %% simple features
    % Width (2,4,6,8)
    X(:,1) = log2(X(:,1));
    X(:, 17) = X(:,9).*X(:,13);
    X(:, 18) = X(:,12).*X(:,13);
    X(:, 19) = X(:,13).*X(:,13);
    
    % IQ size (8 to 80 (increments of 8)
    X(:,3) = log(X(:,3) ./8 );
 
    % LSQ size (8 to 80 (increments of 8)
    X(:,4) = log2( X(:,4));
    
    % RF size (40 to 160 (increments of 8)
    X(:,5) = log2( X(:,5));
    
    % RF read ports (2 to 16 (increments of 2)
    X(:,6) = log2( X(:,6));
    
    % RF write ports (1 to 8 (increments of 1)
    X(:,7) = log2( X(:,7));
    
    % Gshare size 1K to 32K (two powers)
    X(:,8) = log2( X(:,8));
    
    % BTB size 1K 2K 4K
    X(:,9) = log2( X(:,9));
    
    % Branches allowed 8,16,24,32
    X(:,10) =  log(X(:,10));
    
    % L1 lcache size 8K to 128K
    X(:,11) =  log2(X(:,11));
    % L1 Dcache size 8K to 128K
    X(:,12) =  log2(X(:,12));
    % L2 Ucache size 256K to 4M
    X(:,13) =  sqrt(X(:,13));
    
    % Depth 9 to 36 (increments of 3)
    X(:,14) =  (X(:,14));
    X(:,14) = normalize(X(:,14));
    
    %% combined features
%     % add some empirical good polynomial features (x1*x2, x2*x3, etc.)
     X(:, 15) = ( X(:,7).*X(:,14));
     X(:, 16) = X(:,8).*X(:,14);
     X(:, 17) = (X(:,9).*X(:,14));
     X(:, 18) = X(:,13).*X(:,14);
     
    X(:, 19) = X(:,7).*X(:,1);
    X(:, 20) = X(:,8).*X(:,1);
    X(:, 21) = X(:,12).*X(:,1);
    X(:, 22) = X(:,13).*X(:,1);
  
    X(:, 23) = X(:,7).*X(:,9);
    X(:, 24) = X(:,8).*X(:,9);
    X(:, 25) = X(:,12).*X(:,9);
    X(:, 26) = X(:,13).*X(:,9);
    
    X(:, 27) = X(:,6).*X(:,1);
    X(:, 28) = X(:,7).*X(:,1);
     
%     %Add one colume 
%     X = [ones(size(X,1),1),X];

    X = normalize(X);     
    
  %  X = x2fx(X, 'quadratic');

end

