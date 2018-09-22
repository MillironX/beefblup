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

% Coerce all id fields to string format
strings = [1 3 4];
data(:,strings) = cellfun(@num2str, data(:,strings), 'UniformOutput', false);

% Create a lookup lambda function to find the animal represented by a
% certain id
animalrow = @(id) find(strcmp(data(:,1), id));
ids = [data{:,1}];
numanimals = length(data(:,1));

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
        disp(['Column "' colname '" does not have any unique animals and will be removed'])
        disp('from this analysis');
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

% Define a "normal" animal as one of the last in the groups, provided that
% all traits do not have null values
normal = cell([1 length(headers)-5]);
for i = 6:length(headers)
   for j = numanimals:-1:1
      if not(cellfun(@isempty, data(j,i)))
         normal(i - 5) = data(j,i);
         break
      end
   end
end

% Print the results of the "normal" definition
disp(' ')
disp('For the purposes of this analysis, a "normal" animal will be defined')
disp('by the following traits:')
for i = 6:length(headers)
    disp([headers{i} ': ' normal{i-5}])
end
disp(' ')
disp('If no animal matching this description exists, the results may appear')
disp('outlandish, but are still as correct as the accuracy suggests')
disp(' ')

% Form the fixed effect matrix
X = zeros(numanimals, sum(numgroups)-length(numgroups)+1);
X(:,1) = ones(1, numanimals);

% Create an external counter that will increment through both loops
I = 2;

% Store the traits in a string cell array
adjustedtraits = cell(1, sum(numgroups)-length(numgroups));

% Iterate through each group
for i = 1:length(normal)
    % Find the traits that are present in this trait
    traits = uniquecell(data(:,i+5));
    
    % Remove the "normal" version from the analysis
    normalindex = find(strcmp(traits, normal{i}));
    traits(normalindex)  = [];
    
    % Iterate inside of the group
    for j = 1:length(traits)
        matchedindex = find(strcmp(data(:,i+5), traits{j}));
        X(matchedindex, I) = 1;
        
        % Add this trait to the string
        adjustedtraits(I - 1) = traits(j);
        
        % Increment the big counter
        I = I + 1;
    end
end

% Create an empty matrix for the additive relationship matrix
A = zeros(numanimals, numanimals);

% Create lambdas to find sire and dam of each animal
dam = @(id) [data{animalrow(num2str(id)), 3}];
sire = @(id) [data{animalrow(num2str(id)), 4}];

% Create the additive relationship matrix by the FORTRAN method presented
% by Henderson
for i = 1:numanimals
   if strcmp(sire(i), 'NaN') && strcmp(dam(i), 'NaN')
       for j = 1:(i-1)
          A(j,i) = 0; 
       end
       A(i,i) = 1;
       continue
   end
   
   if strcmp(sire(i), 'NaN') && not(strcmp(dam(i), 'NaN'))
       for j = 1:(i-1)
           A(j,i) = A(j,str2double(dam(i)));
           A(i,j) = A(j,str2double(dam(i)));
       end
       A(i,i) = 1;
       continue
   end
   
   if strcmp(dam(i), 'NaN') && not(strcmp(sire(i), 'NaN'))
       for j=1:(i-1)
           A(j,i) = A(j,str2double(sire(i)));
           A(i,j) = A(j,str2double(sire(i)));
       end
       A(i,i) = 1;
       continue
   end
   
   for j=1:(i-1)
       A(j,i) = 0.5.*(A(j,str2double(sire(i))) + A(j,str2double(dam(i))));
       A(i,j) = 0.5.*(A(j,str2double(sire(i))) + A(j,str2double(dam(i))));
   end
   A(i,i) = 1 + 0.5.*A(str2double(sire(i)), str2double(dam(i)));
   continue
     
end

% Extract the observed data
Y = cell2mat(data(:, 5));

% The identity matrix for random effects
Z = eye(numanimals, numanimals);

% Prompt for heritablity
h2 = input('What is the heritablity for this trait? >> ');
lambda = (1-h2)/h2;

% Use the mixed-model equations
solutions = [X'*X X'*Z; Z'*X (Z'*Z)+(inv(A).*lambda)]\[X'*Y; Z'*Y];

% Find the accuracies
diaginv = diag(inv([X'*X X'*Z; Z'*X (Z'*Z)+(inv(A).*lambda)]));
reliability = 1 - diaginv.*lambda;

% Ask the user for where they would like the file saved
[savename, savepath, ~] = uiputfile('*.txt', 'Save your beefblup results', 'results');

% Find how many traits we found BLUE for
numgroups = numgroups - 1;

% Start printing results to output
fileID = fopen([savepath savename], 'w');
fprintf(fileID, 'beefblup Results Report\n');
fprintf(fileID, 'Produced using beefblup for MATLAB (');
fprintf(fileID, '%s', 'https://github.com/millironx/beefblup');
fprintf(fileID, ')\n\n');
fprintf(fileID, 'Input:\t');
fprintf(fileID, '%s', fullname);
fprintf(fileID, '\nAnalysis performed:\t');
fprintf(fileID, date);
fprintf(fileID, '\nTrait examined:\t');
fprintf(fileID, [headers{5}]);
fprintf(fileID, '\n\n');

% Print base population stats
fprintf(fileID, 'Base Population:\n');
for i = 1:length(numgroups)
   fprintf(fileID, '\t');
   fprintf(fileID, [headers{i+5}]);
   fprintf(fileID, ':\t');
   fprintf(fileID, [normal{i}]);
   fprintf(fileID, '\n');
end
fprintf(fileID, '\tMean ');
fprintf(fileID, [headers{5}]);
fprintf(fileID, ':\t');
fprintf(fileID, num2str(solutions(1)));
fprintf(fileID, '\n\n');

I = 2;

% Contemporary group adjustments
fprintf(fileID, 'Contemporary Group Effects:\n');
for i = 1:length(numgroups)
   fprintf(fileID, '\t');
   fprintf(fileID, [headers{i+5}]);
   fprintf(fileID, '\tEffect\tReliability\n');
   for j = 1:numgroups(i)
      fprintf(fileID, '\t');
      fprintf(fileID, [adjustedtraits{I-1}]);
      fprintf(fileID, '\t');
      fprintf(fileID, num2str(solutions(I)));
      fprintf(fileID, '\t');
      fprintf(fileID, num2str(reliability(I)));
      fprintf(fileID, '\n');
      
      I = I + 1;
   end
   fprintf(fileID, '\n');
end
fprintf(fileID, '\n');

% Expected breeding values
fprintf(fileID, 'Expected Breeding Values:\n');
fprintf(fileID, '\tID\tEBV\tReliability\n');
for i = 1:numanimals
   fprintf(fileID, '\t');
   fprintf(fileID, [data{i,1}]);
   fprintf(fileID, '\t');
   fprintf(fileID, num2str(solutions(i+I-1)));
   fprintf(fileID, '\t');
   fprintf(fileID, num2str(reliability(i+I-1)));
   fprintf(fileID, '\n');
end

fprintf(fileID, '\n - END REPORT -');
fclose(fileID);