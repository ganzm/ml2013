function [ ] = showConfusionMatrix( actual, predicted )
[confusionMatrix,~] = confusionmat(actual,predicted); 
score = (5*confusionMatrix(1,2)+confusionMatrix(2,1))/size(actual,1);

figure; imagesc(confusionMatrix), title([num2str(confusionMatrix)]);
colormap('jet'); colorbar;
xlabel('predicted class label');
set(gca,'XTickLabel',{'','-1','','1',''})
ylabel('actual class label');
set(gca,'YTickLabel',{'','-1','','1',''})
grid on;

disp(['Score would be: ', num2str(score)])

end

