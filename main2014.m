% Load datasets
load businesslicences2014.mat
load LocalArea.mat

% Get needed columns
LocalArea2 = businesslicences2014.LocalArea;
BusinessType = businesslicences2014.BusinessType;

% Create array with needed columns
truncArray = cat(2,BusinessType,LocalArea2);

% Remove all rows with missing LocalArea values
TF = not(cellfun('isempty', truncArray));
truncArray(TF(:,2)==0,:) = [];

% 
[n,d] = size(LocalArea);
counts = zeros(n,200);
C = cell(n,5);
for i = 1:n
    we = truncArray(strmatch(LocalArea{i,1}, truncArray(:,2), 'exact'),1);
    weTable = cell2table(we,'VariableNames',{'BusinessType'});
    weTable.BusinessType = categorical(weTable.BusinessType);
    [t,j] = size(hist(weTable.BusinessType));
    counts(i,1:j) = hist(weTable.BusinessType);
   
    % get each unique business type in LocalArea{i,1}
    [uniqueType, ~, id] = unique(weTable.BusinessType); 
    frequency = histc(id, 1:numel(uniqueType));
    frequency = categorical(frequency);
    freqWithArea = cat(2,uniqueType,frequency);
    
    [sorted index] = sort(freqWithArea(:,2), 'descend');
    sortedWithArea = freqWithArea(index,:);
    decategorize = cellstr(sortedWithArea);
    
    fprintf('\nTop 10 business types for area %s: \n',LocalArea{i,1});
    
    for k = 1:5
        fprintf('%s\n',decategorize{k,1});
        C{i,k} = decategorize{k,1};
    end
end

T = cell2table(C);
T.Properties.RowNames = {'West End','Central Business/Downtown','Strathcona','Grandview-Woodland','Hastings-Sunrise','West Point Grey','Kitsilano','Fairview','Mount Pleasant','Dunbar-Southlands','Arbutus Ridge','Shaughnessy','South Cambie','Riley Park','Kensington-Cedar Cottage','Renfrew-Collingwood','Kerrisdale','Oakridge','Sunset','Victoria-Fraserview','Killarney','Marpole'};
writetable(T,'Top5Table2014.csv');