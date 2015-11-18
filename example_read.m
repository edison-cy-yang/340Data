load businesslicences.mat

%test code to see the number of issued businesses
c = ones(60251,1);
%{} are used to extract the data of the table
%there are text in our data so we cannot use matrix
c = strcmp(businesslicences{:,6},'Issued');
num = sum(c~=0);