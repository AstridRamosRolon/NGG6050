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
fprintf('The likelihood is: %.2f \nThe log-likelihood is: %.2f\n', ...
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
            fprintf(['The probability of %d quanta being released with a %.1f ' ...
                'release probability is %.2f\n'], quanta, release_prob, outcome);
            
        else 
            prob_8(t) = outcome;
            fprintf(['The probability of %d quanta being released with a %.1f ' ...
                'release probability is %.2f\n'], quanta, release_prob, outcome);
        end 
    end
end

%% Exercise 4
% You keep going and conduct 100 separate experiments and end up with these 
% results:
% What is the most likely value of p (which we typically refer to as p,which 
% is pronounced as "p-hat" and represents the maximum-likelihood estimate of 
% a parameter in the population given our sample with a resolution of 0.01?
% BONUS: Use a fitting procedure to find 

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

