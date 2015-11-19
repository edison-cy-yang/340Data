% Duplicate businesslicences table
cleanBusinessLicences = businesslicences;

% Convert Status, BusinessType to a categorical arrays
cleanBusinessLicences.Status = categorical(cleanBusinessLicences.Status);
cleanBusinessLicences.BusinessType = categorical(cleanBusinessLicences.BusinessType);

% Add concatenated BusinessName and BusinessTradeName
cleanBusinessLicences1 = table(strcat(cleanBusinessLicences.BusinessName, '-', cleanBusinessLicences.BusinessTradeName));
cleanBusinessLicences1.Properties.VariableNames = {'ConcatName'};
cleanBusinessLicences = [cleanBusinessLicences cleanBusinessLicences1];

% Generate Array containing all words from BusinessName and 
% BusinessTradeName (delimeters: ' ', '(', ')', '"', '&', [0-9]*, '+', 
% '-', '#', ',', '.', ';', '@', '/', "'", '$', '!', ':', '*')
delims = ' |\(|\)|\"|\&|[0-9]*|\+|\-|\#|\,|\.|\;|\@|\/|''|\$|\!|\:|\*';
splitTable = regexpi(cleanBusinessLicences.ConcatName, delims, 'split');
bagOfWords = unique([splitTable{:}]');
bagOfWords = bagOfWords(not(cellfun('isempty', bagOfWords)));