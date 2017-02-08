function [] = ViewResults(resultFile)
%VIEWRESULTS displays the images along with the results from the given file

dirprefix = 'OutputFiles/';

fid = fopen(resultFile);

tline = fgetl(fid);
while ischar(tline)
    C = strsplit(tline,'\t');
    fprintf('Turkey Oak Percentage: %s\n', C{1});
    fprintf('Wiregrass Percentage: %s\n', C{2});
    fprintf('Litter Percentage: %s\n', C{3});
    fprintf('Sand Percentage: %s\n', C{4});
    fprintf('Other Percentage: %s\n', C{5});
    fprintf('Press any key to continue\n');
    
    figure(1);
    hold on;
    filename = strcat(dirprefix, C{6});
    imshow(filename);
    title(C{6});
    hold off;
    
    waitforbuttonpress;
    
    close(1);
    
    tline = fgetl(fid);
end

fclose(fid);

end