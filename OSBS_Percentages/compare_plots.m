function [] = compare_plots(results)
%COMPARE_GLOBAL compares abundance estimates per material across both plots
%
% Inputs:
%  results - nx7 cell array of results where n is the number of entries
%
% Outputs:
%  none

[n, ~] = size(results);

plot1errors = [];
plot2errors = [];
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
                
                if(strcmp(firstname(9:12), '2616'))
                    %plot2
                    plot2errors = [plot2errors, percentages_abs(abundance1, abundance2)];
                else
                    %plot1
                    plot1errors = [plot1errors, percentages_abs(abundance1, abundance2)];
                end
            end
        end
    end
end

materials = cell(0);
materials{1} = 'Turkey Oak';
materials{2} = 'Wiregrass';
materials{3} = 'Litter';
materials{4} = 'Sand';
materials{5} = 'Other';

%Plot 1
for i=1:5
    figure();
    hold on;
    hist(plot1errors(i,:));
    titlestr = sprintf('%s Error Histogram - Plot 1', materials{i});
    title(titlestr);
    xlim([0 1]);
    xlabel('Error (Abundance)');
    ylabel('Occurrence');
    hold off;
end

%Plot 1
for i=1:5
    figure();
    hold on;
    hist(plot2errors(i,:));
    titlestr = sprintf('%s Error Histogram - Plot 2', materials{i});
    title(titlestr);
    xlim([0 1]);
    xlabel('Error (Abundance)');
    ylabel('Occurrence');
    hold off;
end

end