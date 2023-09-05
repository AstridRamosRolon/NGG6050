%% Exercise #1: If someone gets a positive test, is it "statistically significant" at the p<0.05 level? Why or why not?

    % Yes, if the p-value is p<0.05, it suggests that the positive test 
    % is "statistically significant". 
    % 
    % H:  When the test gets back a positive it means the person is infected
    %     and when it gets a negative when the person is not infected.
    % H0: The result of the test results negative or positive regardless of
    %     the status of infection.
    %
    % If the p-value is p≥0.05 there is not enough evidence, so we reject the
    % hypothesis (H) and accept the null hypothesis (H0). In other words, it 
    % doesn't strongly support the claim that the person is infected or not 
    % infected. Conversly, if the p-value is p<0.05 we reject the H0 and 
    % accept the H. Meaning, that there is evidence to say that the positive
    % or negative results reflects the status of infection. The p-value alone 
    % doesn't tell you the probability of being infected; it tells you the 
    % probability of observing the test result if the null hypothesis were true.

%% Exercise #2: What is the probability that if someone gets a positive test, that person is infected?

clc; clear;

% Parameters
num_samples = 1000;
sensitivity = 0.95;  % Sensitivity of the test (true positive rate)
specificity = 0.90;  % Specificity of the test (true negative rate)

% Initialize arrays to store results
prior_probabilities = 0:0.01:1;  % Range of prior probabilities from 0 to 1 in steps of 0.1
probabilities_infected_given_positive = zeros(size(prior_probabilities));

% Loop through different prior probabilities
for i = 1:length(prior_probabilities)
    prior_probability = prior_probabilities(i);

    % Generate a random dataset of test results
    test_results = rand(1, num_samples) < (prior_probability * sensitivity + (1 - prior_probability) * (1 - specificity));

    % Calculate the probability of being infected given a positive test
    P_positive_given_infected = sensitivity;  % Probability of testing positive given infected
    P_infected = prior_probability;  % Prior probability of being infected
    P_positive = sum(test_results) / num_samples;  % Probability of testing positive

    P_infected_given_positive = (P_positive_given_infected * P_infected) / P_positive;

    % Store the result in the array
    probabilities_infected_given_positive(i) = P_infected_given_positive;
end

% Display the results
for i = 1:length(prior_probabilities)
    fprintf('Prior Probability: %.4f, Probability of being infected given a positive test: %f\n', prior_probabilities(i), probabilities_infected_given_positive(i));
end

% Plot the results
figure;
plot(prior_probabilities, probabilities_infected_given_positive);
xlabel('Prior Probability of Infection');
ylabel('Probability of Being Infected Given a Positive Test');
title('Probability vs. Prior Probability of Infection');
grid on;