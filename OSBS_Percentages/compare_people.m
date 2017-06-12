function [] = compare_people(results)
%COMPARE_PEOPLE compares each person's abundance estimates against
%themselves to measure internal consistency
%
% Inputs:
%  results - nx7 cell array of results where n is the number of entries
%
% Outputs:
%  none

[n, ~] = size(results);

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

nonzeronames = cell(0);
medians = [];
prctiles25 = [];
prctiles75 = [];

for i=1:m
    thisnameserrors = [];
    for j=1:n
        if(strcmp(names(i), results(j,7)))
            for k=1:n
                if(strcmp(names(i), results(k,7)))
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
                            
                            thisnameserrors = [thisnameserrors, percentage_metric(abundance1, abundance2)];
                        end
                    end
                end
            end
        end
    end
    
    if(length(thisnameserrors) > 0)
        figure();
        hold on;
        hist(thisnameserrors);
        title(strcat(names(i), ' vs Self'), 'Interpreter', 'none');
        xlim([0 1]);
        xlabel('Error (Abundance)');
        ylabel('Occurrence');
        hold off;

        nonzeronames = [nonzeronames names(i)];
        medians = [medians prctile(thisnameserrors, 50)];
        prctiles25 = [prctiles25 prctile(thisnameserrors, 25)];
        prctiles75 = [prctiles75 prctile(thisnameserrors, 75)];
    end
end

[~, I] = sort(medians);

medians_sorted = medians(I);
prctiles25_sorted = prctiles25(I);
prctiles75_sorted = prctiles75(I);
names_sorted = nonzeronames(I);

for i=1:length(names_sorted)
    names_sorted{i} = CleanFileName(names_sorted{i});
end

inds = 1:length(names_sorted);

fillx = [inds, fliplr(inds)];
filly = [prctiles25_sorted, fliplr(prctiles75_sorted)];

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
title('Comparison of Errors to Self');
hold off;

end