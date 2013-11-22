function [] = writeOutput( file_name, data)

disp(['write result to ' file_name]);

fileID = fopen(file_name, 'w');
for item = data
    fprintf(fileID,'%d\n', item);
end
fclose(fileID);

end

