% Compleated the HW with help from Chat GTP:
% https://chat.openai.com/share/07e4aa59-1e1c-4dbb-9f68-cf51e838dbc3

clear; clc;
Age = [3, 4, 5, 6, 7, 8, 9, 11, 12, 14, 15, 16, 17];
Wing_Length = [1.4, 1.5, 2.2, 2.4, 3.1, 3.2, 3.2, 3.9, 4.1, 4.7, 4.5, 5.2, 5];

%% Plot the relationship between Age and Wing Length.

scatter(Age, Wing_Length, ...
    'LineWidth',2)
title('Relationship between Age and Wing Length')
xlabel('Age')
ylabel('Wing Length')

%% Calculate and plot the regression line.

% Fit a linear regression model
X = [ones(length(Age), 1), Age']; % Design matrix
[b, bint] = regress(Wing_Length', X); % Fit the model

% Plot the data and regression line
scatter(Age, Wing_Length, 'LineWidth', 2)
hold on
plot(Age, X * b, 'LineWidth', 2)

%% Can you reject H0 : b = 0?

% Yes, we can reject the null hypothesis that the slope (b) equals zero.

%% Calculate and plot the confidence intervals on the slope of the regression.

% Calculate the confidence intervals for the slope
slope_CI = bint(2, :);

% Display the confidence intervals on the plot
ymin = X * slope_CI(1); % Lower bound
ymax = X * slope_CI(2); % Upper bound
plot(Age, ymin, '--r', 'LineWidth', 1.5) % Lower bound
plot(Age, ymax, '--r', 'LineWidth', 1.5) % Upper bound

title('Relationship between Age and Wing Length')
xlabel('Age')
ylabel('Wing Length')

% Add a legend
legend({'Data', 'Regression Line', 'Confidence Intervals'})

%%  Calculate r squared (the coefficient of determination)

% Calculate the predicted values
predicted_values = X * b;

% Calculate the mean of the observed values
mean_observed = mean(Wing_Length);

% Calculate the total sum of squares
SS_total = sum((Wing_Length - mean_observed).^2);

% Calculate the residual sum of squares
SS_residual = sum((Wing_Length - predicted_values).^2);

% Calculate R-squared
R_squared = 1 - (SS_residual / SS_total);

% Display R-squared
fprintf('R-squared: %.4f\n', R_squared);

%% Calculate Pearson's r

% Calculate Pearson's correlation coefficient (r)
r = corr(Age', Wing_Length', 'Type', 'Pearson');

% Display Pearson's r
fprintf('Pearson''s r: %.4f\n', r);

%% Add some noise to the data and see how the regression changes

% Add random noise to the Wing_Length data
rng(123); % Seed for reproducibility
noise = randn(size(Wing_Length)); % Generate random noise
noisy_Wing_Length = Wing_Length + noise;

% Fit a linear regression model to the noisy data
X = [ones(length(Age), 1), Age']; % Design matrix
[b, ~] = regress(noisy_Wing_Length', X); % Fit the model

% Calculate the predicted values
predicted_values = X * b;

% Plot the noisy data and regression line
scatter(Age, noisy_Wing_Length, 'LineWidth', 2)
hold on
plot(Age, predicted_values, 'LineWidth', 2)

title('Relationship between Age and Noisy Wing Length')
xlabel('Age')
ylabel('Noisy Wing Length')

% Calculate R-squared for the noisy data
mean_observed = mean(noisy_Wing_Length);
SS_total = sum((noisy_Wing_Length - mean_observed).^2);
SS_residual = sum((noisy_Wing_Length - predicted_values).^2);
R_squared = 1 - (SS_residual / SS_total);

% Display R-squared for the noisy data
fprintf('R-squared for Noisy Data: %.4f\n', R_squared);


