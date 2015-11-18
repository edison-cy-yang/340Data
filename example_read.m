load businesslicences.mat
load businesslicences2011.mat
load businesslicences2012.mat
load businesslicences2013.mat
load businesslicences2014.mat

%test code to see the number of issued businesses
c = ones(60251,1);
%{} are used to extract the data of the table
%there are text in our data so we cannot use matrix
c = strcmp(businesslicences{:,6},'Issued');
num = sum(c~=0);
%test comment: hi edwin and al