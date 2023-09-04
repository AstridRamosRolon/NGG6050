%% Exercise #1: If someone gets a positive test, is it "statistically significant" at the p<0.05 level? Why or why not?

%% Frequentist approach:

    % If the p-value is p<0.05, it suggests that the probability of getting a positive test 
    % result when the person is not infected (i.e., a false positive) is less than 5%. If the 
    % p-value is p≥0.05, it suggests that there is not enough evidence to conclude that the 
    % positive test result is statistically significant. In other words, it doesn't strongly 
    % support the claim that the person is infected. The p-value alone doesn't tell you the 
    % probability of being infected; it tells you the probability of observing the test result
    % if the null hypothesis were true.

clc; clear;
    % Define parameters:
    n_sim = 10000; % number of simulations
    n_test = 1000; % number of tests per simulation
    p = 0.02; % prevalence of desease
    false_pos = 0.05; % false positive rate

    % Initialize variable counting number of positive tests:
    n_pos = 0;

    % Simulate:
    for i = 1:n_sim
        % Generate random numbers for each test:
        test = rand(n_test,1) < p + (1 - p) * false_pos;
        % Check if any test is positive:
        if any(test)
            n_pos = n_pos + 1;
        end
    end

    % Calculate p-value:
    p_value = n_pos / n_sim;

    % Check if p-value is less than 0.05:
    if p_value < 0.05
        fprintf('The positive test result is statistically significant (p = %.4f < 0.05).\n', p_value);
    else
        fprintf('The positive test result is not statistically significant (p = %.4f >= 0.05).\n', p_value);
    end

%% Bayesian approach:

    % The concept of a p-value is less straightforward in Bayesian analysis. Bayesian analysis 
    % focuses more on updating prior beliefs with new evidence and providing probabilities for 
    % events rather than testing hypotheses with predefined significance levels. Bayesian analysis
    % provides a probabilistic assessment of the strength of evidence for an event based on your 
    % prior beliefs and the observed data. Whether a positive test result is considered significant 
    % or not depends on the specific context and the threshold you set for your posterior 
    % probabilities, but it's not directly comparable to the p<0.05 significance level used in 
    % frequentist statistics.

clc; clear;
    % Define prior probability of being infected:
    p_infected = 0.02; % 2% prior belief of infection

    % Define likelihood of getting a positive test result if infected:
    likelihood_infected = 1; % True positive rate
    likelihood_uninfected = 0.05; % False positive rate

    % Calculate posterior probability of being infected using Bayes' rule:
    p_infected_pos = p_pos_infected * p_infected / (p_pos_infected ...
    * p_infected + p_pos_uninfected * (1 - p_infected));

    % Check if posterior probability is greater than 0.05:
    if p_infected_pos > 0.05
        fprintf('The positive test result is statistically significant (p = %.4f > 0.05).\n', p_infected_pos);
    else
        fprintf('The positive test result is not statistically significant (p = %.4f <= 0.05).\n', p_infected_pos);
    end

%% Exercise #2: What is the probability that if someone gets a positive test, that person is infected?
clc; clear;
    % Define the range of priors (infection rates) from 0 to 1 in steps of 0.01:
    prior_range = 0:0.01:1;

    % Define likelihood of getting a positive test result if infected:
    likelihood_infected = 1; % True positive rate (assuming perfect sensitivity)
    likelihood_uninfected = 0.05; % False positive rate

    % Iterate through each prior (infection rate):
    for i = 1:length(prior_range);
        % Calculate prior probability for current prior:
        prior_p_infected = prior_range(i);
        % Calculate posterior probability of being infected using Bayes' theorem:
        posterior_p_infected = likelihood_infected * prior_p_infected / ...
        (likelihood_infected * prior_p_infected + likelihood_uninfected * (1 - prior_p_infected));
        % Store posterior probability:
        posterior_p(i) = posterior_p_infected;
    end

    % Plot posterior probability as a function of prior probability:
    figure;
    plot(prior_range, posterior_p, 'LineWidth', 2);
    xlabel('Prior probability of being infected');
    ylabel('Posterior probability of being infected');
    title('Posterior probability as a function of prior probability');

    % Calculate the probability that if someone gets a positive test, that person is infected:
    p_infected_pos = likelihood_infected * prior_p_infected / ...
        (likelihood_infected * prior_p_infected + likelihood_uninfected * (1 - prior_p_infected));

    % Print result:
    fprintf('The probability that if someone gets a positive test, that person is infected is %.4f.\n', p_infected_pos);

    

