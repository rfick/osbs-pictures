function [] = convert_results_file(filename, newfilename)
%CONVERT_RESULTS_FILE converts a results file from old format to current
%format
%
% Inputs:
%  filename - filename of results file
%  newfilename - filename of new file to be created

fileID = fopen(filename);

fileIDWrite = fopen(newfilename, 'w');

tline = fgetl(fileID);
while ischar(tline)
    C = strsplit(tline, ' ');
    
    %If line is not empty
    if(length(C) == 10)
        fprintf(fileIDWrite, '%s\t%s\t%s\t%s\t%s\t%s %s %s %s %s\n', C{1}, C{2}, C{3}, C{4}, C{5}, C{6}, C{7}, C{8}, C{9}, C{10});
    end
    
    tline = fgetl(fileID);
end

fclose(fileID);
fclose(fileIDWrite);


end