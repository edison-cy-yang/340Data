% Load datasets
load businesslicences2011.mat
load LocalArea.mat

% Get needed columns
LocalArea2 = businesslicences.LocalArea;
BusinessType = businesslicences.BusinessType;

% Create array with needed columns
truncArray = cat(2,BusinessType,LocalArea2);

% Remove all rows with missing LocalArea values
TF = not(cellfun('isempty', truncArray));
truncArray(TF(:,2)==0,:) = [];

% 
[n,d] = size(LocalArea);
counts = zeros(n,200);
for i = 1:n
    we = truncArray(strmatch(LocalArea{i,1}, truncArray(:,2), 'exact'),1);
    weTable = cell2table(we,'VariableNames',{'LocalArea'});
    weTable.LocalArea = categorical(weTable.LocalArea);
    [t,j] = size(hist(weTable.LocalArea));
    counts(i,1:j) = hist(weTable.LocalArea);
end

[sortedCounts indicesCounts] = sort(counts, 2, 'descend');

sortedCounts = sortedCounts(:,1:10);
indicesCounts = indicesCounts(:,1:10);

%get the unique business types
uniqueType = unique(truncArray(:,1));

C = cell(n,10);

for j=1:n
    fprintf('\nTop 10 business types for area %s: \n',LocalArea{j,1});
    
    for k=1:10
        fprintf('%s\n',uniqueType{indicesCounts(j,k),1});
        C{j,k} = uniqueType{indicesCounts(j,k),1};
    end
end

T = cell2table(C);
T.Properties.RowNames = {'West End','Central Business/Downtown','Strathcona','Grandview-Woodland','Hastings-Sunrise','West Point Grey','Kitsilano','Fairview','Mount Pleasant','Dunbar-Southlands','Arbutus Ridge','Shaughnessy','South Cambie','Riley Park','Kensington-Cedar Cottage','Renfrew-Collingwood','Kerrisdale','Oakridge','Sunset','Victoria-Fraserview','Killarney','Marpole'};
writetable(T,'Top10Table2011.csv');