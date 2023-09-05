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

OpenAI. (2023). ChatGPT (August 3 Version) [Large language model]. https://chat.openai.com
https://chat.openai.com/share/8e1126d8-d883-4a02-81bb-4a793159ebc1 % Link to ChatGTP conversation

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

% Output
Prior Probability: 0.0000, Probability of being infected given a positive test: 0.000000
Prior Probability: 0.0100, Probability of being infected given a positive test: 0.087963
Prior Probability: 0.0200, Probability of being infected given a positive test: 0.171171
Prior Probability: 0.0300, Probability of being infected given a positive test: 0.261468
Prior Probability: 0.0400, Probability of being infected given a positive test: 0.258503
Prior Probability: 0.0500, Probability of being infected given a positive test: 0.314570
Prior Probability: 0.0600, Probability of being infected given a positive test: 0.452381
Prior Probability: 0.0700, Probability of being infected given a positive test: 0.455479
Prior Probability: 0.0800, Probability of being infected given a positive test: 0.417582
Prior Probability: 0.0900, Probability of being infected given a positive test: 0.485795
Prior Probability: 0.1000, Probability of being infected given a positive test: 0.533708
Prior Probability: 0.1100, Probability of being infected given a positive test: 0.583799
Prior Probability: 0.1200, Probability of being infected given a positive test: 0.530233
Prior Probability: 0.1300, Probability of being infected given a positive test: 0.571759
Prior Probability: 0.1400, Probability of being infected given a positive test: 0.630332
Prior Probability: 0.1500, Probability of being infected given a positive test: 0.603814
Prior Probability: 0.1600, Probability of being infected given a positive test: 0.630705
Prior Probability: 0.1700, Probability of being infected given a positive test: 0.630859
Prior Probability: 0.1800, Probability of being infected given a positive test: 0.628676
Prior Probability: 0.1900, Probability of being infected given a positive test: 0.752083
Prior Probability: 0.2000, Probability of being infected given a positive test: 0.683453
Prior Probability: 0.2100, Probability of being infected given a positive test: 0.728102
Prior Probability: 0.2200, Probability of being infected given a positive test: 0.661392
Prior Probability: 0.2300, Probability of being infected given a positive test: 0.750859
Prior Probability: 0.2400, Probability of being infected given a positive test: 0.754967
Prior Probability: 0.2500, Probability of being infected given a positive test: 0.730769
Prior Probability: 0.2600, Probability of being infected given a positive test: 0.771875
Prior Probability: 0.2700, Probability of being infected given a positive test: 0.761128
Prior Probability: 0.2800, Probability of being infected given a positive test: 0.844444
Prior Probability: 0.2900, Probability of being infected given a positive test: 0.852941
Prior Probability: 0.3000, Probability of being infected given a positive test: 0.814286
Prior Probability: 0.3100, Probability of being infected given a positive test: 0.834278
Prior Probability: 0.3200, Probability of being infected given a positive test: 0.830601
Prior Probability: 0.3300, Probability of being infected given a positive test: 0.820681
Prior Probability: 0.3400, Probability of being infected given a positive test: 0.856764
Prior Probability: 0.3500, Probability of being infected given a positive test: 0.827114
Prior Probability: 0.3600, Probability of being infected given a positive test: 0.834146
Prior Probability: 0.3700, Probability of being infected given a positive test: 0.861520
Prior Probability: 0.3800, Probability of being infected given a positive test: 0.898010
Prior Probability: 0.3900, Probability of being infected given a positive test: 0.830717
Prior Probability: 0.4000, Probability of being infected given a positive test: 0.896226
Prior Probability: 0.4100, Probability of being infected given a positive test: 0.859823
Prior Probability: 0.4200, Probability of being infected given a positive test: 0.880795
Prior Probability: 0.4300, Probability of being infected given a positive test: 0.930524
Prior Probability: 0.4400, Probability of being infected given a positive test: 0.842742
Prior Probability: 0.4500, Probability of being infected given a positive test: 0.925325
Prior Probability: 0.4600, Probability of being infected given a positive test: 0.877510
Prior Probability: 0.4700, Probability of being infected given a positive test: 0.940000
Prior Probability: 0.4800, Probability of being infected given a positive test: 0.885437
Prior Probability: 0.4900, Probability of being infected given a positive test: 0.903883
Prior Probability: 0.5000, Probability of being infected given a positive test: 0.878004
Prior Probability: 0.5100, Probability of being infected given a positive test: 0.915879
Prior Probability: 0.5200, Probability of being infected given a positive test: 0.932075
Prior Probability: 0.5300, Probability of being infected given a positive test: 0.955408
Prior Probability: 0.5400, Probability of being infected given a positive test: 0.876923
Prior Probability: 0.5500, Probability of being infected given a positive test: 0.933036
Prior Probability: 0.5600, Probability of being infected given a positive test: 0.917241
Prior Probability: 0.5700, Probability of being infected given a positive test: 0.924061
Prior Probability: 0.5800, Probability of being infected given a positive test: 0.958261
Prior Probability: 0.5900, Probability of being infected given a positive test: 0.932612
Prior Probability: 0.6000, Probability of being infected given a positive test: 0.943709
Prior Probability: 0.6100, Probability of being infected given a positive test: 0.939222
Prior Probability: 0.6200, Probability of being infected given a positive test: 0.924647
Prior Probability: 0.6300, Probability of being infected given a positive test: 0.922188
Prior Probability: 0.6400, Probability of being infected given a positive test: 0.944099
Prior Probability: 0.6500, Probability of being infected given a positive test: 0.934191
Prior Probability: 0.6600, Probability of being infected given a positive test: 0.933036
Prior Probability: 0.6700, Probability of being infected given a positive test: 0.996088
Prior Probability: 0.6800, Probability of being infected given a positive test: 0.936232
Prior Probability: 0.6900, Probability of being infected given a positive test: 0.975446
Prior Probability: 0.7000, Probability of being infected given a positive test: 0.958213
Prior Probability: 0.7100, Probability of being infected given a positive test: 0.950000
Prior Probability: 0.7200, Probability of being infected given a positive test: 0.933151
Prior Probability: 0.7300, Probability of being infected given a positive test: 0.965877
Prior Probability: 0.7400, Probability of being infected given a positive test: 0.968320
Prior Probability: 0.7500, Probability of being infected given a positive test: 0.976027
Prior Probability: 0.7600, Probability of being infected given a positive test: 0.957560
Prior Probability: 0.7700, Probability of being infected given a positive test: 0.951235
Prior Probability: 0.7800, Probability of being infected given a positive test: 0.991968
Prior Probability: 0.7900, Probability of being infected given a positive test: 1.007383
Prior Probability: 0.8000, Probability of being infected given a positive test: 0.931373
Prior Probability: 0.8100, Probability of being infected given a positive test: 0.957090
Prior Probability: 0.8200, Probability of being infected given a positive test: 0.987326
Prior Probability: 0.8300, Probability of being infected given a positive test: 0.990578
Prior Probability: 0.8400, Probability of being infected given a positive test: 0.966102
Prior Probability: 0.8500, Probability of being infected given a positive test: 0.990798
Prior Probability: 0.8600, Probability of being infected given a positive test: 1.008642
Prior Probability: 0.8700, Probability of being infected given a positive test: 0.970070
Prior Probability: 0.8800, Probability of being infected given a positive test: 0.987013
Prior Probability: 0.8900, Probability of being infected given a positive test: 0.978588
Prior Probability: 0.9000, Probability of being infected given a positive test: 0.979381
Prior Probability: 0.9100, Probability of being infected given a positive test: 0.982386
Prior Probability: 0.9200, Probability of being infected given a positive test: 0.973274
Prior Probability: 0.9300, Probability of being infected given a positive test: 0.991582
Prior Probability: 0.9400, Probability of being infected given a positive test: 0.983480
Prior Probability: 0.9500, Probability of being infected given a positive test: 0.985262
Prior Probability: 0.9600, Probability of being infected given a positive test: 1.000000
Prior Probability: 0.9700, Probability of being infected given a positive test: 0.999458
Prior Probability: 0.9800, Probability of being infected given a positive test: 1.006486
Prior Probability: 0.9900, Probability of being infected given a positive test: 0.999469
Prior Probability: 1.0000, Probability of being infected given a positive test: 1.001054
