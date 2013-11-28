function [cityNames, trainResult] = dataread( filepath ) 
%%
% parse a single file
%
% Parameters
% filepath:      file path to the log file to analyse
% 
% returns: todo

trainResult  = [];

disp(['reading file ' filepath]);

textScanPattern = '%s';

% openfiles
fid = fopen(filepath);

rowCount = 0;
cityNames = cell(0,0);

while true   
    % parse line
    lineCell = textscan(fid, textScanPattern, 1, 'delimiter', ';');

    lineString = char(lineCell{1});
    if isempty(lineString)
        % break read loop
        break;
    end
    
    % increment rowcount
    rowCount = rowCount + 1;
    
    lastCommaIndex = strlastindexof(lineString, ',');
    if lastCommaIndex ~= -1
        
        countryCodeString = lineString((lastCommaIndex+1):end);
        rest = lineString(1:(lastCommaIndex-1));
        secondLastCommaIndex = strlastindexof(rest, ',');
        cityCodeString = lineString((secondLastCommaIndex+1):(lastCommaIndex-1));
        
        countryCode = str2num(countryCodeString);
        cityCode = str2num(cityCodeString);
        trainResult = [trainResult;cityCode, countryCode];
        
        cityNameString = lineString(1:(secondLastCommaIndex-1));
    else
        cityNameString = lineString;
    end
    
    % to lower case
    cityNameString = lower(cityNameString);

    % append cityName
    cityNames{rowCount} = cityNameString;
    
end

% close file
fclose(fid);

end