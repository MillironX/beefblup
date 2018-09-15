% beefblup
% Main script for performing single-variate BLUP to find beef cattle
% breeding values
% Usage: beefblup
% (C) 2018 Thomas A. Christensen II
% Licensed under BSD-3-Clause License

% Prepare the workspace for computation
clear
clc
close all

% Import data from a suitable spreadsheet
[name, path] = uigetfile('*.xlsx','Select a beefblup worksheet');
fullname = [path name];
clear name path
[~, ~, data] = xlsread(fullname);

% Extract the headers into a separate array
headers = data(1,:);
data(1,:) = [];

% Convert the string dates to numbers
data(:,2) = num2cell(datenum(data(:,2)));

% Sort the array by date
data = sortrows(data,2);

% Create a lookup lambda function to find the animal represented by a
% certain id
ids = data(:,1);
animalrow = @(id) find(ids == id);
numanimals = length(ids);

% Store column numbers that need to be deleted
% Column 6 contains an intermediate Excel calculation and always needs to
% be deleted
colstodelete = 6;

% Coerce each group to string format
for i = 7:length(headers)
   data(:,i) = cellfun(@num2str, data(:,i), 'UniformOutput', false); 
end

% Find any columns that need to be deleted
for i = 7:length(headers)
    if length(uniquecell(data(:,i))) <= 1
        colname = headers{i};
        disp(['Column "' colname '" does not have any unique animals and will be removed from this analysis.']);
        colstodelete = [colstodelete i]; 
    end
end

% Delete the appropriate columns from the datasheet and the headers
data(:,colstodelete) = [];
headers(colstodelete) = [];

% Determine how many contemporary groups there are
numgroups = ones(1, length(headers)-5);
for i = 6:length(headers)
    numgroups(i-5) = length(uniquecell(data(:,i)));
end

% If there are more groups than animals, then the analysis cannot continue
if sum(numgroups) >= numanimals
   disp('There are more contemporary groups than animals. The analysis will now abort.');
   return
end

