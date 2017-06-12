function [new_filename] = CleanFileName(filename)
%CLEANFILENAME cleans a file name (like 'Ronald_Fick.txt') with underscores
%into a form that displays better in plot figures (like 'Ronald Fick')
%
% Inputs:
%  filename - string of filename
%
% Outputs:
%  newfilename - string reformatted

new_filename = [];

for i=1:length(filename)
    if(filename(i) == '.')
        break;
    elseif(filename(i) == '_')
        new_filename = [new_filename ' '];
    else
        new_filename = [new_filename filename(i)];
    end
end

end