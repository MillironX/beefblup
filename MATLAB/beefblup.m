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
