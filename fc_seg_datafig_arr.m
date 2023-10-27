clear; 
clc;

% Set the working directory
cd '/Users/astridrr/Desktop/Wiers_Lab/ABC_FC/Astrid_code'

% Create a directory for storing figures
fig_folder = '/Users/astridrr/Desktop/Wiers_Lab/ABC_FC/Astrid_code/figures';
mkdir(fig_folder);

% Load the data
load('Schaefer_400ROI_Data.mat'); % 3D matrix containing ROI:ROI:Subject connectivity
data = readtable('seg_dem_cognorm.xlsx'); % Segregation data

% Load the text file containing the IDs for subject data that will be visualized 
subs = dlmread('cognorm_subs.txt')';
subs_23_44 = dlmread('cognorm_subs_23_44.txt');
subs_47_69 = dlmread('cognorm_subs_47_69.txt');
subs_70_92 = dlmread('cognorm_subs_70_92.txt');

%% Image Fisher Z-transformed correlation matrix (all subs)

figure; % Create a new figure

fig_1 = imagesc(mean(stacked_Z(:,:,subs), 3)); % Create the image and store the handle

set(gcf, 'Color', 'w'); % Set the figure background color to white
set(gca,'CLim',[0 2.5]);% Set limits

colorbar;% Add color bar
colormap(slanCM('turbo')); % Set the colormap

cbar = colorbar;
cbar.Label.String = 'Fisher s Z-score units'; % Add lable
cbar.Label.Color = 'k'; % Set color to black

% Title and labels
title('Functional Connectivity Correlation Matrix (all subjects)','Color','k');
xlabel('Schaefer 17 Network ROIs','Color','k');
ylabel('Schaefer 17 Network ROIs', 'Color', 'k');

fig1_filename = fullfile(fig_folder, 'fig1.png');

%% Image Fisher Z-transformed correlation matrix (23-44)

figure; % Create a new figure

fig_2 = imagesc(mean(stacked_Z(:,:,subs_23_44), 3)); % Create the image and store the handle

set(gcf, 'Color', 'w'); % Set the figure background color to white
set(gca,'CLim',[0 2.5]);% Set limits

colorbar;% Add color bar
colormap(slanCM('turbo')); % Set the colormap

cbar = colorbar;
cbar.Label.String = 'Fisher s Z-score units'; % Add lable
cbar.Label.Color = 'k'; % Set color to black

% Title and labels
title('Functional Connectivity Correlation Matrix (ages 23-44)','Color','k');
xlabel('Schaefer 17 Network ROIs','Color','k');
ylabel('Schaefer 17 Network ROIs', 'Color', 'k');

fig2_filename = fullfile(fig_folder, 'fig2.png');

%% Image Fisher Z-transformed correlation matrix (47-69)

figure; % Create a new figure

fig_3 = imagesc(mean(stacked_Z(:,:,subs_47_69), 3)); % Create the image and store the handle

set(gcf, 'Color', 'w'); % Set the figure background color to white
set(gca,'CLim',[0 2.5]); % Set limits

colorbar;% Add color bar
colormap(slanCM('turbo')); % Set the colormap

cbar = colorbar;
cbar.Label.String = 'Fisher s Z-score units'; % Add lable
cbar.Label.Color = 'k'; % Set color to black

% Title and labels
title('Functional Connectivity Correlation Matrix (ages 47-69)','Color','k');
xlabel('Schaefer 17 Network ROIs','Color','k');
ylabel('Schaefer 17 Network ROIs', 'Color', 'k');

fig3_filename = fullfile(fig_folder, 'fig3.png');

%% Image Fisher Z-transformed correlation matrix (70-92)

figure; % Create a new figure

fig_4 = imagesc(mean(stacked_Z(:,:,subs_70_92), 3)); % Create the image and store the handle

set(gcf, 'Color', 'w'); % Set the figure background color to white
set(gca,'CLim',[0 2.5]);% Set limits

colorbar;% Add color bar
colormap(slanCM('turbo')); % Set the colormap

cbar = colorbar;
cbar.Label.String = 'Fisher s Z-score units'; % Add lable
cbar.Label.Color = 'k'; % Set color to black

% Title and labels
title('Functional Connectivity Correlation Matrix (ages 70-92)','Color','k');
xlabel('Schaefer 17 Network ROIs','Color','k');
ylabel('Schaefer 17 Network ROIs', 'Color', 'k');

fig4_filename = fullfile(fig_folder, 'fig4.png');

%% Correlation age vs sex for All Networks

figure; % Create a new figure

fig_5 = scatter(data, 'AgeatMRI', 'AllNetworks', 'filled', 'MarkerFaceColor', '#0072BD');

set(gcf, 'Color', 'w');% Set the figure background color to white

% Changing marker style and size
fig_5.Marker = 'o'; % Marker style (e.g., 'o' for circles)

% Changing marker color
fig_5.MarkerFaceColor = 'b'; % Marker fill color (e.g., 'b' for blue)

% Adding grid lines
grid on;

% Title, labels and legend
title('Age at MRI vs. All Networks', 'Color', 'k');
xlabel('Age at MRI','Color', 'k');
ylim([0 1]);
ylabel('Segregation','Color', 'k');

fig5_filename = fullfile(fig_folder, 'fig5.png');

%% Correlation age vs sex for SomatomotorA and Salience_VentralAttentionA

figure; % Create a new figure

fig_6 = scatter(data, 'AgeatMRI', 'Salience_VentralAttentionA', 'filled', 'MarkerFaceColor', '#EDB120');
hold on;

scatter(data, 'AgeatMRI', 'SomatomotorA', 'filled', 'MarkerFaceColor', '#4DBEEE');

set(gcf, 'Color', 'w');% Set the figure background color to white

% Changing marker style and size
fig_6.Marker = 'o'; % Marker style (e.g., 'o' for circles)

% Changing marker color
fig_6.MarkerFaceColor = 'b'; % Marker fill color (e.g., 'b' for blue)

% Adding grid lines
grid on;

% Title, labels and legend
xlabel('Age at MRI','Color', 'k');
ylabel('Segregation','Color', 'k');
ylim([0 1]);
legend('Salience\\Ventral Attention A','Somatomotor A','Location','northeastoutside');

fig6_filename = fullfile(fig_folder, 'fig6.png');

%% Correlation age vs sex for SomatomotorA and PeripheralVisual

figure; % Create a new figure

fig_7 = scatter(data, 'AgeatMRI', 'PeripheralVisual', 'filled', 'MarkerFaceColor', '#7E2F8E');
hold on;

scatter(data, 'AgeatMRI', 'SomatomotorA', 'filled', 'MarkerFaceColor', '#4DBEEE');

set(gcf, 'Color', 'w');% Set the figure background color to white

% Changing marker style and size
fig_7.Marker = 'o'; % Marker style (e.g., 'o' for circles)

% Changing marker color
fig_7.MarkerFaceColor = 'b'; % Marker fill color (e.g., 'b' for blue)

% Adding grid lines
grid on;

% Title, labels and legend
xlabel('Age at MRI','Color', 'k');
ylabel('Segregation','Color', 'k');
ylim([0 1]);
legend('PeripheralVisual','SomatomotorA','Location','northeastoutside');

fig7_filename = fullfile(fig_folder, 'fig7.png');

%% Save the figures 
saveas(fig_1, fig1_filename, 'png'); % For fig_1
saveas(fig_2, fig2_filename, 'png'); % For fig_2
saveas(fig_3, fig3_filename, 'png'); % For fig_3
saveas(fig_4, fig4_filename, 'png'); % For fig_4
saveas(fig_5, fig5_filename, 'png'); % For fig_5
saveas(fig_6, fig6_filename, 'png'); % For fig_6
saveas(fig_7, fig7_filename, 'png'); % For fig_7



