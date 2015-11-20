% Get needed columns
LocalArea = businesslicences.LocalArea;
BusinessType = businesslicences.BusinessType;

% Create array with needed columns
truncArray = cat(2,BusinessType,LocalArea);

% Remove all rows with missing LocalArea values
TF = not(cellfun('isempty', truncArray));
truncArray(TF(:,2)==0,:) = [];

% Convert truncArray from array to table
% truncTable = cell2table(truncArray,'VariableNames',{'BusinessType', 'LocalArea'});
% Convert LocalArea, BusinessType to categorical arrays
% truncTable.LocalArea = categorical(truncTable.LocalArea);
% truncTable.BusinessType = categorical(truncTable.BusinessType);
% mode(truncTable.LocalArea);
% Create a table for each LocalArea
% 01-West End
% 02-Central Business/Downtown
% 03-Strathcona
% 04-Grandview-Woodland
% 05-Hastings-Sunrise
% 06-West Point Grey
% 07-Kitsilano
% 08-Fairview
% 09-Mount Pleasant
% 10-Dunbar-Southlands
% 11-Arbutus Ridge
% 12-Shaughnessy
% 13-South Cambie
% 14-Riley Park
% 15-Kensington-Cedar Cottage
% 16-Renfrew-Collingwood
% 17-Kerrisdale
% 18-Oakridge
% 19-Sunset
% 20-Victoria-Fraserview
% 21-Killarney
% 22-Marpole

we = truncArray(strmatch('01-West End', truncArray(:,2), 'exact'),1);
weTable = cell2table(we,'VariableNames',{'LocalArea'});
weTable.LocalArea = categorical(weTable.LocalArea);
