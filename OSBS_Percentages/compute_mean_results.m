function [mean_results] = compute_mean_results(results)
%COMPUTE_MEAN_RESULTS compares each person's abundance estimates against
%themselves to measure internal consistency
%
% Inputs:
%  results - nx7 cell array of results where n is the number of entries
%
% Outputs:
%  mean_results - mx6 cell array of mean results

[n, ~] = size(results);

mean_results = cell(0);

%Keep track of already processed filenames
filenames = containers.Map;

count = 1;

for i=1:n
    turkeyoak = str2num(cell2mat(results(i,1)));
    wiregrass = str2num(cell2mat(results(i,2)));
    litter = str2num(cell2mat(results(i,3)));
    sand = str2num(cell2mat(results(i,4)));
    other = str2num(cell2mat(results(i,5)));
    filename = cell2mat(results(i,6));
    author = results(i,7);
    
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
    
    if(~isKey(filenames, filenametrunc))
        filenames(filenametrunc) = 1; %If box is empty, put something in it
        mean_results{count, 1} = mean(turkeyoak);
        mean_results{count, 2} = mean(wiregrass);
        mean_results{count, 3} = mean(litter);
        mean_results{count, 4} = mean(sand);
        mean_results{count, 5} = mean(other);
        mean_results{count, 6} = filenametrunc;
        
        count = count + 1;
    end
end

end