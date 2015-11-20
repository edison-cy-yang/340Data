% Load datasets
% load businesslicences.mat
% load LocalArea.mat

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

topTen = cell(22,10);
% topTen = cell2table(topTen);
% for j=1:n
%     for k=1:10
%         topTen(j,k) = uniqueType{indicesCounts(j,k),1};
%     end
% end

topTen(:,:) = uniqueType{indicesCounts(1:22,1:10),1};
