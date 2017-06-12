function [] = ViewResults(results)
%VIEWRESULTS displays the images along with the results from the given
%results cell array
%
% Inputs:
%  results - nx7 cell array with n entries
%
% Outputs:
%  none

[n, ~] = size(results);

dirprefix = 'FrameRemovedImages/';

for i=1:n
    turkeyoak = str2num(cell2mat(results(i,1)));
    wiregrass = str2num(cell2mat(results(i,2)));
    litter = str2num(cell2mat(results(i,3)));
    sand = str2num(cell2mat(results(i,4)));
    other = str2num(cell2mat(results(i,5)));
    filename = cell2mat(results(i,6));
    author = results(i,7);
    
    fprintf('Author: %s\n', cell2mat(results(i,7)));
    fprintf('Filename: %s\n', cell2mat(results(i,6)));
    fprintf('Turkey Oak Percentage: %f\n', str2num(cell2mat(results(i,1))));
    fprintf('Wiregrass Percentage: %f\n', str2num(cell2mat(results(i,2))));
    fprintf('Litter Percentage: %f\n', str2num(cell2mat(results(i,3))));
    fprintf('Sand Percentage: %f\n', str2num(cell2mat(results(i,4))));
    fprintf('Other Percentage: %f\n', str2num(cell2mat(results(i,5))));
    fprintf('\n');
    
    filenametrunc = filename(1:18);
    
    for j=1:n
        secondname = results(j,6);
        secondname = cell2mat(secondname);
        secondname = secondname(1:18);
        if(strcmp(filenametrunc, secondname) && i~=j)
            turkeyoak = [turkeyoak; str2num(cell2mat(results(j,1)))];
            wiregrass = [wiregrass; str2num(cell2mat(results(j,2)))];
            litter = [litter; str2num(cell2mat(results(j,3)))];
            sand = [sand; str2num(cell2mat(results(j,4)))];
            other = [other; str2num(cell2mat(results(j,5)))];
            filename = [filename; cell2mat(results(j,6))];
            author = [author; results(j,7)];
            
            fprintf('Author: %s\n', cell2mat(results(j,7)));
            fprintf('Filename: %s\n', cell2mat(results(j,6)));
            fprintf('Turkey Oak Percentage: %f\n', str2num(cell2mat(results(j,1))));
            fprintf('Wiregrass Percentage: %f\n', str2num(cell2mat(results(j,2))));
            fprintf('Litter Percentage: %f\n', str2num(cell2mat(results(j,3))));
            fprintf('Sand Percentage: %f\n', str2num(cell2mat(results(j,4))));
            fprintf('Other Percentage: %f\n', str2num(cell2mat(results(j,5))));
            fprintf('\n');
        end
    end
    
    fprintf('Average Result\n');
    fprintf('Plot: %s\n', filenametrunc);
    fprintf('Turkey Oak Percentage: %f\n', mean(turkeyoak));
    fprintf('Wiregrass Percentage: %f\n', mean(wiregrass));
    fprintf('Litter Percentage: %f\n', mean(litter));
    fprintf('Sand Percentage: %f\n', mean(sand));
    fprintf('Other Percentage: %f\n', mean(other));
    fprintf('\n');
    
    figure(1);
    hold on;
    filename = strcat(dirprefix, cell2mat(results(i,6)));
    imshow(filename);
    title(cell2mat(results(i,6)), 'Interpreter', 'none');
    hold off;
    
    waitforbuttonpress;
    
    close(1);
end

end