function [] = writeOutput( file_name, city, country)
%WRITEOUTPUT Summary of this function goes here
%   Detailed explanation goes here


disp(['write result to ' file_name]);

fileID = fopen(file_name, 'w');
for i = 1:length(city)
    fprintf(fileID,'%d,%d\n', city(i), country(i));
end
fclose(fileID);

end

