function Training = removeOutliers(Training)
newX = [];
newTrainResult = [];

X = Training.X;

countryResult = Training.trainResult(:,2);
cityResult = Training.trainResult(:,1);
uniqueCountries = unique(countryResult);

for currentCountryIndex = 1:length(uniqueCountries)
   currentCountry = uniqueCountries(currentCountryIndex);
   cityOnCurrentCountry = cityResult(countryResult==currentCountry);
   uniqueCityOnCurrentCountry = unique(cityOnCurrentCountry);
   
   for currentCityIndex=1:length(uniqueCityOnCurrentCountry)
      currentCity = uniqueCityOnCurrentCountry(currentCityIndex); 
       XtoInspect = X((cityResult==currentCity) & (countryResult == currentCountry),:);
       goodFeatures = sum(XtoInspect) >= round(size(XtoInspect,1)/5);
       samplesToKeepIndex = sum(XtoInspect(:,goodFeatures),2) > 0;
       
       heightOfNewX = size(XtoInspect(samplesToKeepIndex,:),1);
       
       % disp
       disp(['for country: ', num2str(currentCountry), ' and city: ', num2str(currentCity), ' remove: ', num2str(size(XtoInspect,1) - heightOfNewX)])
       
       
       newX = [newX; XtoInspect(samplesToKeepIndex,:)];
       newTrainResult = [newTrainResult; [currentCity*ones(heightOfNewX,1), currentCountry*ones(heightOfNewX,1)]];   
   end
   
end

Training.X = newX;
Training.trainResult = newTrainResult;



end