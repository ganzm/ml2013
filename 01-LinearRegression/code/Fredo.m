function [X, Y] = Fredo()

trainingData = csvread('../testdata/training.csv');
Y = trainingData(:,15);
X = trainingData(:,1:14);
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
   
   X1  = X(:,1 );
   X2  = X(:,2 );
   X3  = X(:,3 );
   X4  = X(:,4 );
   X5  = X(:,5 );
   X6  = X(:,6 );
   X7  = X(:,7 );
   X8  = X(:,8 );
   X9  = X(:,9 );
   X10 = X(:,10);
   X11 = X(:,11);
   X12 = X(:,12);
   X13 = X(:,13);
   X14 = X(:,14);
   
   X1  = X1./2;  
   X2  = X2./8;
   X3  = X3./8;
   X  = X./8;  
   X5  = X5./8;  
   X6  = X6./2;  
   X7  = X7;
   X8  = log2(X8);
   X9  = log2(X9);
   X10 = X10./8;
   X1 = log2(X1);
   X12 = log2(X12); 
   X13 = log2(X13);
   X14 = X14./3;
   
   X1  = X1;
   X2  = X2 - 3;
   X3  = X3;
   X  = X;
   X5  = X5 - 4;
   X6  = X6;
   X7  = X7;
   X8  = X8 - 9;
   X9  = X9 - 7;
   X10 = X10;
   X1 = X1 - 5;
   X12 = X12 - 5;
   X13 = X13 - 8;
   X14 = X14 - 2;
    

 %% Find something out about X14
 figure(1337);
whitebg(1337,'k'); 
 inspect = X14;
 
 for i=1:length(X13)
    xi = inspect(i);
    x13 = X13(i);
    
     cc=hsv(length(unique(inspect)));
     colorIndex = xi - min(inspect)+1;
     
     plot(x13,Y(i), '+', 'color', cc(colorIndex,:));
     hold on;
 end
 

% figure
% for i=1:length(X14)
%    x14 = X14(i);
%    x13 = X13(i);
%    
%    if x13 == 4
%       plot(x14,Y(i),'r+'); 
%       hold on;
%    end
%    
% end


%X = [Width,ROB,IQ,LSQ,RFSize,RFRead,RFWrite,Gshare,BTB,Branches,L1Icache,L1Dcache,L2Ucache,Depth];

   


%ordering
X = [X13, X14, X5, X10, X3, X8, X6, X9, X1, X2, X7, X1, X, X12];

%Delay = normalize(Delay);
%X = normalize(X);

