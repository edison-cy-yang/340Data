% Duplicate businesslicences table
cleanBusinessLicences = businesslicences;

% Convert Status, BusinessType to a categorical arrays
cleanBusinessLicences.Status = categorical(cleanBusinessLicences.Status);
cleanBusinessLicences.BusinessType = categorical(cleanBusinessLicences.BusinessType);

% Generate Array containing all words from BusinessName and
% BusinessTradeName:
delims = ' |\(|\)|\"|\&';
splitTable = regexpi(cleanBusinessLicences.BusinessName, delims, 'split');
bagOfWords = unique([splitTable{:}]');
bagOfWords = bagOfWords(not(cellfun('isempty', bagOfWords)));
