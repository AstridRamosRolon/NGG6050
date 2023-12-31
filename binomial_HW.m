%% Exercise 1:
%  Assume that there are 10 quanta available in a nerve terminal, and for a 
%  given release event each is released with a probability of 0.2. For one 
%  such event, what is the probability that 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, or 
%  10 quanta will be released?

clear;clc;

% Parameters:
q = 10;  % Total number of quanta available
p = 0.2; % Probability of releasing a single quantum

% Loop through each possible number of quanta being released (0 to q)
for quanta = 0:q

    % Calculate the probability of observing quanta being released
    outcome = binopdf(quanta, q, p);
    
    % Display the result
    fprintf('The probability of %d quanta being released is %.2f\n', ...
        quanta, outcome)
end

%% Exercise 2:
%  Let's say you know that a given nerve terminal contains exactly 14 quanta 
%  available for release. You have read in the literature that the release 
%  probability of these quanta is low, say 0.1. To assess whether this value 
%  is reasonable, you run a simple experiment: activate the nerve and measure 
%  the number of quanta that are released. The result is 8 quanta. What is 
%  the probability that you would get this result (8 quanta) if the true 
%  probability of release really was 0.1? What about if the true release 
%  probability was much higher; say, 0.7? What about for each decile of 
%  release probability (0.1, 0.2, ... 1.0)? Which value of release probability 
%  did you determine to be the most probable, given your measurement?

clear;clc;

% Parameters:
quanta = 8; % Number of quanta released
q = 14;     % Total number of quanta available
highest_probability = 0;

% Loop through each decile of release probability (0.1-1.0)

for p = 0.1:0.1:1
    
    % Calculate the probability 8 quanta being released at differnt release
    % probabilities
    outcome = binopdf(quanta, q, p);

    % Display the result
    fprintf(['The probability of %d quanta being released with a %.1f release ' ...
        'probability is %.2f\n'], quanta, p, outcome)

    % Check if thehighest_probability current probability has a higher
    % probability than the previous maximum
    if outcome > highest_probability
        highest_probability = outcome;
        most_probable_p = p;
    end
end

% Display the most probable release probability

fprintf(['The post probable release probability is %.1f'], most_probable_p)

%% Exercise 3:
% Not feeling convinced by your single experiment (good scientist!), you 
% repeat it under identical conditions. This time you measure 5 quanta that 
% were released. Your sample size has now doubled, to two measurements. You 
% now want to take into account both measurements when you assess the 
% likelihoods of different possible values of the underlying release 
% probability. To do so, assume that the two measurements in this sample are 
% independent of one another; that is, the value of each result had no 
% bearing on the other. In this case, the total likelihood is simply the 
% product of the likelihoods associated with each separate measurement. It 
% is also typical to compute the logarithm of each likelihood and take their 
% sum, which is often more convenient. What are the values of the total 
% likelihood and total log-likelihood in this example, if we assume that the 
% true release probability is 0.1?

% Of course, knowing those values of the likelihood and log-likelihood is 
% not particularly useful until you can compare them to the values computed 
% for other possible values for the release probability, so you can determine 
% which value of release probability is most likely, given the data. 
% Therefore, compute the full likelihood and log-likelihood functions using 
% deciles of release probability between 0 and 1. What is the maximum value? 
% Can you improve your estimate by computing the functions at a higher 
% resolution? How does the estimate improve as you increase the sample size?


clear;clc;

% Parameters:
p = 0.1; % Probability of releasing a single quantum
q = 14;  % Total number of quanta available
q_8 = 8; % 8 quanta released
q_5 = 5; % 5 quanta released

% Calculate the probability of observing quanta 5 and 8 being released
p_8 = binopdf(q_8,q,p);
p_5 = binopdf(q_5,q,p);

% Calculate the Likelihood
likelihood = p_8*p_5;

% Calculate the Log-Likelihood
log_likelihood = log(p_8) + log(p_5);
fprintf('The likelihood is: %.2f \nThe log-likelihood is: %.2f\n\n', ...
    likelihood, log_likelihood)

% Loop through each decile of release probability (0.1-1.0)

quanta_data = [5 8];
prob_5 = zeros(1, 11);
prob_8 = zeros(1, 11);


for quanta = quanta_data
    p = 0:0.1:1;
    
    for t = 1:11
        % Get the release probability for this iteration
        release_prob = p(t);

        % Calculate the probability of quanta being released at the current release probability
        outcome = binopdf(quanta, q, release_prob);

        % Display the result
        if quanta == 5
            prob_5(t) = outcome;
        else 
            prob_8(t) = outcome;
        end 
    end
end

p_release = 0:0.1:1;

% Set the display format for numeric values
format bank;

% Create a table with the specified format
T = table(p_release', prob_5', prob_8', 'VariableNames', {'Probability of release', '5 quanta', '8 quanta'});

% Display the table
disp(T);

% Calculate the likelihood and log-likelihood for prob_5 and prob_8
likelihood_5 = prod(prob_5);
log_likelihood_5 = sum(log(prob_5));

likelihood_8 = prod(prob_8);
log_likelihood_8 = sum(log(prob_8));

fprintf('The likelihood for 5 quanta released is: %.6f\n', likelihood_5);
fprintf('The log-likelihood for 5 quanta released is: %.6f\n\n', log_likelihood_5);

fprintf('The likelihood for 8 quanta released is: %.6f\n', likelihood_8);
fprintf('The log-likelihood for 8 quanta released is: %.6f\n\n', log_likelihood_8);

%% From this part down I used AI
% OpenAI. (2023). ChatGPT (August 3 Version) [Large language model]. https://chat.openai.com
% https://chat.openai.com/share/c20bf627-ee9f-47c4-a517-8a791c7dde8d

% Find the maximum likelihood and corresponding release probability for 5 quanta
[max_likelihood_5, idx_5] = max(prob_5);
max_prob_5 = p_release(idx_5);

% Find the maximum likelihood and corresponding release probability for 8 quanta
[max_likelihood_8, idx_8] = max(prob_8);
max_prob_8 = p_release(idx_8);

% Display the results
fprintf('Maximum Likelihood for 5 quanta released: %.6f\n', max_likelihood_5);
fprintf('Corresponding Release Probability for 5 quanta: %.2f\n\n', max_prob_5);

fprintf('Maximum Likelihood for 8 quanta released: %.6f\n', max_likelihood_8);
fprintf('Corresponding Release Probability for 8 quanta: %.2f\n\n', max_prob_8);

clear; clc;
close all; % Close any existing figures

% Parameters:
p = 0.1; % Probability of releasing a single quantum
q = 14;  % Total number of quanta available
quanta_data = [5, 8]; % Quanta data for simulation
resolution = 0.01; % Resolution for release probability

% Create a range of release probabilities with higher resolution
p_release = 0:resolution:1;

% Initialize arrays to store results
likelihood_5 = zeros(1, length(p_release));
log_likelihood_5 = zeros(1, length(p_release));
likelihood_8 = zeros(1, length(p_release));
log_likelihood_8 = zeros(1, length(p_release));

% Create a figure to hold the likelihood plots
figure;

% Simulate data with increasing sample sizes
sample_sizes = [10, 100, 1000, 10000]; % You can add more sample sizes as needed

for n = sample_sizes
    fprintf('Simulating data with sample size %d...\n', n);
    
    for i = 1:length(p_release)
        release_prob = p_release(i);
        
        % Simulate data for 5 quanta
        data_5 = binornd(q, release_prob, 1, n);
        % Calculate likelihood and log-likelihood for 5 quanta
        likelihood_5(i) = prod(binopdf(data_5, q, release_prob));
        log_likelihood_5(i) = sum(log(binopdf(data_5, q, release_prob)));
        
        % Simulate data for 8 quanta
        data_8 = binornd(q, release_prob, 1, n);
        % Calculate likelihood and log-likelihood for 8 quanta
        likelihood_8(i) = prod(binopdf(data_8, q, release_prob));
        log_likelihood_8(i) = sum(log(binopdf(data_8, q, release_prob)));
    end
    
    % Find and display the maximum likelihood and the corresponding release probability
    [max_likelihood_5, idx_5] = max(likelihood_5);
    max_prob_5 = p_release(idx_5);
    
    [max_likelihood_8, idx_8] = max(likelihood_8);
    max_prob_8 = p_release(idx_8);
    
    fprintf('Sample Size: %d\n', n);
    fprintf('Maximum Likelihood for 5 quanta released: %.6f\n', max_likelihood_5);
    fprintf('Corresponding Release Probability for 5 quanta: %.2f\n', max_prob_5);
    fprintf('Maximum Likelihood for 8 quanta released: %.6f\n', max_likelihood_8);
    fprintf('Corresponding Release Probability for 8 quanta: %.2f\n', max_prob_8);
    fprintf('--------------------------------------\n');
    
    % Plot likelihood curves for 5 quanta and 8 quanta
    subplot(2, 2, find(sample_sizes == n));
    plot(p_release, likelihood_5, 'r', 'LineWidth', 1.5);
    hold on;
    plot(p_release, likelihood_8, 'b', 'LineWidth', 1.5);
    title(sprintf('Sample Size: %d', n));
    xlabel('Release Probability');
    ylabel('Likelihood');
    legend('5 quanta', '8 quanta');
    grid on;
    hold off;
    
    pause(1); % Pause to allow time to see the plot (adjust as needed)
end



%% Exercise 4
% You keep going and conduct 100 separate experiments and end up with these 
% results:
% What is the most likely value of p (which we typically refer to as p,which 
% is pronounced as "p-hat" and represents the maximum-likelihood estimate of 
% a parameter in the population given our sample with a resolution of 0.01?
% BONUS: Use a fitting procedure to find 

clear; clc;

% Measured releases and their corresponding counts
measured_releases = 0:14;
counts = [0 0 3 7 10 19 26 16 16 5 5 0 0 0 0];

% Define the likelihood function
likelihood = @(p) prod(binopdf(measured_releases, 14, p));

% Create a range of p values with the desired resolution
p_values = 0:0.01:1;

% Initialize arrays to store likelihood values
likelihood_values = zeros(size(p_values));

% Calculate the likelihood for each p value
for i = 1:length(p_values)
    likelihood_values(i) = likelihood(p_values(i));
end

% Find the value of p that maximizes the likelihood
[max_likelihood, idx] = max(likelihood_values);
p_hat = p_values(idx);

% Display the maximum-likelihood estimate (p-hat)
fprintf('Maximum-Likelihood Estimate (p-hat): %.2f\n', p_hat);

% Plot the likelihood curve
figure;
plot(p_values, likelihood_values, 'b', 'LineWidth', 1.5);
hold on;
scatter(p_hat, max_likelihood, 100, 'r', 'filled');
title('Likelihood Curve for p');
xlabel('p');
ylabel('Likelihood');
legend('Likelihood', 'Maximum-Likelihood Estimate (p-hat)');
grid on;
hold off;

%% Exercise 5
%  Let's say that you have run an exhaustive set of experiments on this synapse 
%  and have determined that the true release probability is 0.3 (within some 
%  very small tolerance). Now you want to test whether changing the temperature 
%  of the preparation affects the release probability. So you change the 
%  temperature, perform the experiment, and measure 7 quantal events for the 
%  same 14 available quanta. Compute p. Standard statistical inference now 
%  asks the question, what is the probability that you would have obtained 
%  that measurement given a Null Hypothesis of no effect? In this case, no 
%  effect corresponds to an unchanged value of the true release probability 
%  (i.e., its value remained at 0.3 even with the temperature change). What 
%  is the probability that you would have gotten that measurement if your Null 
%  Hypothesis were true? Can you conclude that temperature had an effect?

clear; clc;

% Given data
true_p = 0.3; % Assumed true release probability under the null hypothesis
observed_successes = 7; % Number of successes (quantal events)
total_trials = 14; % Total number of trials (available quanta)

% Calculate p-hat (sample proportion)
p_hat = observed_successes / total_trials;

% Perform a z-test for proportions
alpha = 0.05; % Significance level
z_critical = norminv(1 - alpha/2); % Critical z-value for two-tailed test

% Standard error for proportion
standard_error = sqrt((p_hat * (1 - p_hat)) / total_trials);

% Calculate the z-score
z_score = (p_hat - true_p) / standard_error;

% Calculate the p-value for the two-tailed test
p_value = 2 * (1 - normcdf(abs(z_score)));

% Display the results
fprintf('p-hat (Sample Proportion): %.4f\n', p_hat);
fprintf('z-score: %.4f\n', z_score);
fprintf('p-value: %.4f\n', p_value);

% Check the null hypothesis
if p_value < alpha
    fprintf('Reject the null hypothesis (Ha: changing the temperature has an effect).\n');
else
    fprintf('Fail to reject the null hypothesis (H0: no effect of changing the temperature).\n');
end
