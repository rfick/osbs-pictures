function [] = compare_people_to_mean(results, mean_results)
%COMPARE_PEOPLE_TO_MEAN compares each person's abundance estimates against
%themselves to measure internal consistency
%
% Inputs:
%  results - nx7 cell array of results where n is the number of entries
%  mean_results - px6 cell array of results where m is the number of entries
%
% Outputs:
%  none

[n, ~] = size(results);
[p, ~] = size(mean_results);

%Find all unique names
names = cell(0);

for i=1:n
    name = results(i,7);
    if(any(ismember(name, names)))
        %name is already present
    else
        names = [names; name];
    end
end

m = length(names);

medians = zeros(m, 1);
prctiles25 = zeros(m, 1);
prctiles75 = zeros(m, 1);

for i=1:m
    thisnameserrors = [];
    for j=1:n
        if(strcmp(names(i), results(j,7)))
            for k=1:p
                firstname = results(j,6);
                firstname = cell2mat(firstname);
                firstname = firstname(1:18);
                secondname = mean_results(k,6);
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
                        abundance2(1) = cell2mat(mean_results(k,1));
                        abundance2(2) = cell2mat(mean_results(k,2));
                        abundance2(3) = cell2mat(mean_results(k,3));
                        abundance2(4) = cell2mat(mean_results(k,4));
                        abundance2(5) = cell2mat(mean_results(k,5));

                        thisnameserrors = [thisnameserrors, percentage_metric(abundance1, abundance2)];
                    end
                end
            end
        end
    end
    figure();
    hold on;
    hist(thisnameserrors);
    title(strcat(names(i), ' vs Mean'), 'Interpreter', 'none');
    xlim([0 1]);
    xlabel('Error (Abundance)');
    ylabel('Occurrence');
    hold off;
    
    medians(i) = prctile(thisnameserrors, 50);
    prctiles25(i) = prctile(thisnameserrors, 25);
    prctiles75(i) = prctile(thisnameserrors, 75);
end

[~, I] = sort(medians);

medians_sorted = medians(I);
prctiles25_sorted = prctiles25(I);
prctiles75_sorted = prctiles75(I);
names_sorted = names(I);

for i=1:length(names_sorted)
    names_sorted{i} = CleanFileName(names_sorted{i});
end

inds = 1:length(names_sorted);

fillx = [inds, fliplr(inds)];
filly = [prctiles25_sorted', fliplr(prctiles75_sorted')];

figure();
hold on;
fill(fillx, filly, 'b', 'FaceAlpha', 0.3);
testx = inds;
testy = medians_sorted;
plot(testx, testy);
newlabels = names_sorted;
set(gca, 'XTick', 1:length(newlabels));
set(gca, 'XTickLabel', newlabels);
xlabel('People');
ylabel('Error (Abundance)');
title('Comparison of Errors to Mean');
hold off;

end