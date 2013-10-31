function [ X ] = extractFeaturesGanz( Xraw, Y )
%EXTRACTFEATURESGANZ Summary of this function goes here
%   Detailed explanation goes here

[grad1, grad2, grad3, grad4] = getCorrelation(Xraw, Y) ;

str1.data = grad1;
str1.getMax = @(x) max(x);
str1.createMaxFeature = @createMaxFeatureGrad1;
corrcell{1} = str1;

str2.data = grad2;
str2.getMax = @(x) max(max(x));
str2.createMaxFeature = @createMaxFeatureGrad2;
corrcell{2} = str2;

str3.data = grad3;
str3.getMax = @(x) max(max(max(x)));
str3.createMaxFeature = @createMaxFeatureGrad3;
corrcell{3} = str3;

str4.data = grad4;
str4.getMax = @(x) max(max(max(max(x))));
str4.createMaxFeature = @createMaxFeatureGrad4;
corrcell{4} = str4;

X = [];

for k=1:160

    maxVal = intmin;
    maxIndex = -1;
    for i = 1:length(corrcell)
        tmp = corrcell{i};
        currVal = tmp.getMax(tmp.data);
        if currVal > maxVal
            maxVal = currVal;
            maxIndex = i;
        end
    end

    currVal = corrcell{maxIndex};
    [Xnew, newData] = currVal.createMaxFeature(Xraw, currVal.data, maxVal);
    currVal.data = newData;
    corrcell{maxIndex} = currVal;
    X = [X,Xnew];
end

X = Xraw;
end


function [xNew, grad4New] = createMaxFeatureGrad4(Xraw, grad4, maxVal)

[idx1,idx2,idx3,idx4] = myMax4(grad4);

disp([num2str(maxVal) ' ' 'Use 4 feature on ' num2str(idx1) ' and ' num2str(idx2) ' and ' num2str(idx3) ' and ' num2str(idx4)]);

xNew = Xraw(:,idx1) .* Xraw(:,idx2) .* Xraw(:,idx3) .* Xraw(:,idx4);
grad4(idx1, idx2, idx3, idx4) = 0;
grad4New = grad4;
end

function [i,j] = myMax2(x)
maxVal = max(max(x));
[n1,n2] = size(x);
for i=1:n1 
for j=1:n2 
if maxVal == x(i,j)
   return; 
end
end
end

i=-1;
j=-1;
end

function [i,j,k] = myMax3(x)
maxVal = max(max(max(x)));
[n1,n2,n3] = size(x);
for i=1:n1 
for j=1:n2 
for k=1:n3 
if maxVal == x(i,j,k)
   return; 
end
end
end
end
end


function [i,j,k,l] = myMax4(x)
maxVal = max(max(max(max(x))));
[n1,n2,n3,n4] = size(x);
for i=1:n1 
for j=1:n2 
for k=1:n3 
for l=1:n4 
if maxVal == x(i,j,k,l)
   return; 
end
end
end
end
end
end


function [xNew, grad3New] = createMaxFeatureGrad3(Xraw, grad3,maxVal)
[idx1,idx2,idx3] = myMax3(grad3);
disp([num2str(maxVal) ' ' 'Use cubic feature on ' num2str(idx1) ' and ' num2str(idx2) ' and ' num2str(idx3)]);

xNew = Xraw(:,idx1) .* Xraw(:,idx2) .* Xraw(:,idx3);
grad3(idx1, idx2,idx3) = 0;
grad3New = grad3;
end

function [xNew, grad2New] = createMaxFeatureGrad2(Xraw, grad2,maxVal)
[idx1, idx2] = myMax2(grad2);
disp(['num2str(maxVal) ' ' Use quadratic feature on ' num2str(idx1) ' and ' num2str(idx2)]);

xNew = Xraw(:,idx1) .* Xraw(:,idx2);
grad2(idx1, idx2) = 0;
grad2(idx2, idx1) = 0;
grad2New = grad2;
end

function [xNew, grad1New] = createMaxFeatureGrad1(Xraw, grad1,maxVal)
[~, idx] = max(grad1);
disp([num2str(maxVal) ' ' 'Use linear feature ' num2str(idx)]);

xNew = Xraw(:,idx);
grad1(idx) = 0;
grad1New = grad1;
end


function [grad1, grad2, grad3, grad4] = getCorrelation(x,y) 
%% Test, remove me

d = size(x,2);
grad1 = zeros(d,1);
for i=1:d
    grad1(i) = corr(y, x(:,i));
end
grad1 = abs(grad1);

grad2 = zeros(d,d);
for i=1:d
    for j=1:d
        grad2(i,j) = corr(y, x(:,i) .* x(:,j));
    end
end
grad2 = abs(grad2);

grad3 = zeros(d,d,d);
for i=1:d
    for j=1:d
        for k=1:d
            grad3(i,j,k) = corr(y, x(:,i) .* x(:,j) .* x(:,k));
        end
    end
end
grad3 = abs(grad3);


grad4 = zeros(d,d,d,d);
for i=1:d
    for j=1:d
        for k=1:d
            for l=1:d
            grad4(i,j,k,l) = corr(y, x(:,i) .* x(:,j) .* x(:,k).* x(:,l));
            end
        end
    end
end
grad4 = abs(grad4);

end

