%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adapted from X. Wang 'calc_segre.m' by A. Ramos-Rolon                     %
%                                                                           %
% This code calculates brain functional network connectivity.               %
%                                                                           %
% Input: 1. Fisher Z-transformed correlation matrix for funcrional          %
%           connectivity data in a 3D matrix of form ROIs:ROIs:Subjects.    %
%        2. Text file containing the lables for the ROIs, the labes must    %
%           be denoted by positive integers, negative integes will indicate %
%           'non-miningful' networks and will not be included in the        %
%           segregation calculation.                                        %
%                                                                           %
% Output: .mat file containing segregation values                           % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preping: Set parameters, working directori, files, and variables

clear; 
clc;

% Parameters
ROIs = 400; 
net = 17; % Number fo separate networks
all_net = 18; % Number of separate networks + aggregated networks 
              % + 1 (accounts for mean(separate networks))

% Set the working directory
cd '/Users/astridrr/Desktop/Wiers_Lab/ABC_FC/Astrid_code'

% Create a directory for storing subject data
data_folder = '/Users/astridrr/Desktop/Wiers_Lab/ABC_FC/Astrid_code/sub_sata';
mkdir(data_folder);

% Load the 3D matrix containing ROI:ROI:Subject connectivity data
load('Schaefer_400ROI_Data.mat');

% Specify the number of subjects
num_subs = size(stacked_Z, 3);

% Initialize a Subject:Network matrix to store segregation values
seg_all=zeros(num_subs,all_net);

% Load the ROI labels from a text file
label = dlmread('ROI_labels.txt');

%% Network segregarion calculation

for n = 1:num_subs

    % Access and process the values in the last dimension
    matrix = stacked_Z(:, :, n);
    sub_name = sprintf('sub_%d', n);

    % Create the full path to save the file in the 'sub_data' folder
    file_path = fullfile(data_folder, [sub_name '.mat']);
    
    % Save the matrix to a .mat file in the specified folder
    save(file_path, 'matrix');

    % Initialize variables for within and between network calculations
    within=zeros(17,1);
    numw=zeros(17,1);
    between=zeros(17,1);
    numb=zeros(17,1);

    for i = 1:ROIs
       for j = i+1:ROIs

           % Keep positive connectivity values
           if matrix(i,j)>0 && label(i)>0 && label(j)>0 

               % Collects within network connectivity values
               if label(i) == label(j)
                   within(label(i)) = within(label(i)) + matrix(i,j);
                   numw(label(i)) = numw(label(i))+1;

               % Collects between network connectivity values
               else
                   between(label(i)) = between(label(i)) + matrix(i,j);
                   between(label(j)) = between(label(j)) + matrix(i,j);
                   numb(label(i)) = numb(label(i))+1;
                   numb(label(j)) = numb(label(j))+1;
               end
           end
       end
    end

    % Initialize variables for segregation calculation
    seg=zeros(all_net,1);
    zw=zeros(net,1);
    zb=zeros(net,1);

    for i = 1:net

       % Calculate within network connectivity
       zw(i)=within(i)/numw(i);

       % Calculate between network connectivity
       zb(i)=between(i)/numb(i);

       % Calculate segregation
       seg(i)=(zw(i)-zb(i))/zw(i);
    end
    
    % Averege the segregation for all networks
    seg(18) = mean(seg(1:net)); 
    
    % Stores the segregation values in the seg_all matrix
    seg_all(n,:)=seg';
end

%save seg_all % Saves it without lables

%% Custumize output file (optional)

% Define subject IDs
subject_ids = (1:num_subs)';  % Create a vertical column vector of subject IDs

% Create a new matrix with labels
seg_all = [subject_ids, seg_all];

% Define labels for each network (make sure you have 18 labels)
network_labels = {'Central Visual', 'Peripheral Visual', 'Somatomotor A', ...
    'Somatomotor B', 'Dorsal Attention A', 'Dorsal Attention B', ...
    'Salience/Ventral Attention A', 'Salience/Ventral Attention B', 'Limbic B', ...
    'Limbic A', 'Control A', 'Control B', 'Control C', 'Default A', 'Default B', ...
    'Default C', 'Temporal Parietal', 'All Networks'};

% Define labels for the table
table_labels = [{'Sub ID'}, network_labels];

% Add network labels to the top row
seg_all = [table_labels; num2cell(seg_all)];

save seg_all

%% Expot to Excel (optional)

% Convert the cell array to a table
data_table = cell2table(seg_all(2:end,:), 'VariableNames', seg_all(1,:));

% Specify the file name for the Excel file
file_name = 'seg_all.xlsx';

% Write the table to an Excel file
writetable(data_table, file_name, 'Sheet', 'Sheet1');




