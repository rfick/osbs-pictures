function [] = compare_people_covariance(results)
%COMPARE_PEOPLE_COVARIANCE compares each person's abundance estimates against
%each other's to compute covariance like things
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

covariance = zeros(m, m);

for i=1:m
    thisnameserrors = [];
    counters = ones(m,1);
    for j=1:n
        if(strcmp(names(i), results(j,7)))
            for k=1:n
                kname = results(k,7);
                k_ind = 0;
                for l=1:m
                    if(strcmp(kname, names(l)))
                        k_ind = l;
                        break;
                    end
                end
                
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
                        
                        thisnameserrors(k_ind, counters(k_ind)) = percentage_metric(abundance1, abundance2);
                        counters(k_ind) = counters(k_ind) + 1;
                    end
                end
            end
        end
    end
    
    for j=1:m
        covariance(i,j) = mean(thisnameserrors(j, 1:counters(j)-1));
    end
end

clean_names = names;

for i=1:length(names)
    clean_names{i} = CleanFileName(names{i});
end

figure();
hold on;
imagesc(covariance);
set(gca, 'XTick', 1:length(clean_names));
set(gca, 'XTickLabel', clean_names);
set(gca, 'YTick', 1:length(clean_names));
set(gca, 'YTickLabel', clean_names);
title('Comparison of Errors between Sets');
hold off;

end