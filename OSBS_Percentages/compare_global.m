function [] = compare_global(results)
%COMPARE_GLOBAL compares abundance estimates across all people
%
% Inputs:
%  results - nx7 cell array of results where n is the number of entries
%
% Outputs:
%  none

[n, ~] = size(results);

errors = [];
for j=1:n
    for k=1:n
        firstname = results(j,6);
        firstname = cell2mat(firstname);
        firstname = firstname(1:18);
        secondname = results(k,6);
        secondname = cell2mat(secondname);
        secondname = secondname(1:18);
        if(strcmp(firstname, secondname))
            if(j~=k)
                abundance1 = zeros(5,1);
                abundance1(1) = str2num(cell2mat(results(j,1)));
                abundance1(2) = str2num(cell2mat(results(j,2)));
                abundance1(3) = str2num(cell2mat(results(j,3)));
                abundance1(4) = str2num(cell2mat(results(j,4)));
                abundance1(5) = str2num(cell2mat(results(j,5)));

                abundance2 = zeros(5,1);
                abundance2(1) = str2num(cell2mat(results(k,1)));
                abundance2(2) = str2num(cell2mat(results(k,2)));
                abundance2(3) = str2num(cell2mat(results(k,3)));
                abundance2(4) = str2num(cell2mat(results(k,4)));
                abundance2(5) = str2num(cell2mat(results(k,5)));

                errors = [errors, percentage_metric(abundance1, abundance2)];
            end
        end
    end
end
figure();
hold on;
hist(errors);
title('Global Error Histogram');
xlim([0 1]);
xlabel('Error (Abundance)');
ylabel('Occurrence');
hold off;

fprintf('Mean of errors: %d\n', mean(errors));
fprintf('Std of errors: %d\n', std(errors));

end