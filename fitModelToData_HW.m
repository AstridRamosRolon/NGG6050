% LATER Fitting Exercise
%
% Copyright 2023 by Joshua I. Gold, University of Pennsylvania

% The basic idea in fitting a model to data is to find the parameters of
% the model that provide in some sense the best match of the model to the
% data. This match is provided by the "objective function."
% This exercise is intended to demystify this process by getting you
% to define the initial conditions and objective function for
% fitting the LATER model to RT data. For a much more thorough, but still
% very accessible, overview of model fitting (to behavioral data), here
% is a great place to start:
%
% https://elifesciences.org/articles/49547
%
% For this exercise, recall that the point of the LATER model is that 1/RT is
% distributed as a Gaussian, where we can define the parameters
% of the Gaussian (mu and sigma) with respect to the standard parameters
% of the LATER model (muR and deltaS):
%       mu = muR/deltaS
%       sigma = 1/deltaS
%
% So fitting LATER to behavioral data involves finding parameters
% muR and deltaS that provide the best match to the data, according to
% the appropriate objective function.
%
% Follow along the steps below, some of which will require you to complete
% the code (and therefore hopefully think about how to relate the high-
% level concepts discussed above with the nitty-gritty part of getting
% everything to actually work.

%%  1. Get the data
%
%   Use this code to get a data set (array of RTs from a single condition)
%   to fit, already preprocessed to include correct trials only and remove
%   outliers (including express saccades). See later_getData for details
Path = '/Users/astridrr/Desktop/Courses/Quantitative Neuroscience/LATER'

data = later_getData([], '/Users/astridrr/Desktop/Courses/Quantitative Neuroscience/LATER/LATERdata', 0.2);
RTs = data{1};
clear data

%%  2. Define the objective function
%
% The objective function typically defines the error that you want to 
% minimize between your data and the model predictions. A common objective 
% function is the negative of the sum of the log-likelihoods of the data, 
% given the model parameters. To unpack that for the LATER model:
%
%   1. For each data point (RT from a single trial, in this case) and given
%       set of model parameters, compute the probability of the data, given
%       the model (i.e., the likelihood)
%   2. Take the logarithm
%   3. Sum all these log-likelihoods from all the data points
%   4. Take the negative, because we want to find the minimum (thus
%        corresponding to the maximum likelihood)
%
%   You can define the function simply using an "anonymous function"
%   (https://www.mathworks.com/help/matlab/matlab_prog/anonymous-functions.html), 
%   using this template that assumes that "fits" is a 2x1 vector of
%   [muR, deltaS]:
 
% EXERCISE:
% laterErrFcn = @(fits) <**YOUR OBJECTIVE FUNCTION HERE AS A FUNCTION OF FITS**>;

% Define the likelihood function for a single data point
likelihood_function = @(fits, rt) normpdf(1/rt, fits(1)/fits(2), 1/fits(2));

% Define the negative log-likelihood function for all data points and the model parameters
laterErrFcn = @(fits) -sum(log(arrayfun(@(rt) likelihood_function(fits, rt), RTs)));

%%  3. Define initial conditions
%   
%   For the actual fitting, we will use fmincon
%   (https://www.mathworks.com/help/optim/ug/fmincon.html), which is 
%   "function minimization with constraints." This function allows for 
%   constraints that include upper and lower bounds on the parameters.
%   So here we define those bounds, along with the initial values.
%   We'll use fairly arbitrary values for the lower and upper
%   bounds, but we should pick the initial values more judiciously. HINT: 
%   Recall that the muR and deltaS should be strongly related to 
%   empirical summary statistics of `the (reciprocal) RT distribution.
lowerBounds = [0.001 0.001];
upperBounds = [1000 1000]; 

% EXERCISE:
% initialValues = [<**ADD INITIAL VALUES HERE**>];

% Define the objective function (as defined previously)
likelihood_function = @(fits, rt) normpdf(1/rt, fits(1)/fits(2), 1/fits(2));
laterErrFcn = @(fits) -sum(log(arrayfun(@(rt) likelihood_function(fits, rt), RTs)));

% Define initial values for the parameters [muR, deltaS]
initialValues = [10, 1]; % Replace with your initial values

% Perform the optimization using fmincon
options = optimset('fmincon');
options.Display = 'iter'; % Set to 'off' to suppress output
options.MaxFunEvals = 10000; % Adjust as needed

bestFits = fmincon(laterErrFcn, initialValues, [], [], [], [], lowerBounds, upperBounds, [], options);

% Extract the best-fitting parameters
best_muR = bestFits(1);
best_deltaS = bestFits(2);


%%  4. Run the fits
% 
%   We will be using GlobalSearch . The general advantage of this approach 
%   is to avoid local minima; for details, see:
%   https://www.mathworks.com/help/gads/how-globalsearch-and-multistart-work.html
%  
%   These options seem to work well, but I don't have a stronger
%   rationale for using them. See the Matlab documentation if you really
%   want to dive in and understand them, and let me know if you find
%   better settings!
opts = optimoptions(@fmincon,    ... % "function minimization with constraints"
   'Algorithm',   'active-set',  ...
   'MaxIter',     3000,          ...
   'MaxFunEvals', 3000);

% Definine the "optimization problem" using variables defined above
problem = createOptimProblem('fmincon',    ...
    'objective',   laterErrFcn,     ... % Use the objective function
    'x0',          initialValues,   ... % Initial conditions
    'lb',          lowerBounds,     ... % Parameter lower bounds
    'ub',          upperBounds,     ... % Parameter upper bounds
    'options',     opts);                % Options defined above

% Create a GlobalSearch object
gs = GlobalSearch;

% Define the condition or dataset you want to fit (e.g., 1 for the first condition)
ii = 1;

% Iterate through different conditions or datasets
for ii = 1:5  % Replace numConditions with the actual number of conditions
    % ... (the rest of the code for fitting the LATER model for the current condition)
    
    % Store the results for the current condition
    [fits(ii,:), nllk] = run(gs, problem);
end

% I assumed the stimulus(SF, SNF, WF, WWF, WNF) are the condition 

% Run it, returning the best-fitting parameter values and the negative-
% log-likelihood returned by the objective function
[fits(ii,:), nllk] = run(gs,problem);

%%  5. Evaluate the fits
%
%   EXERCISE: How do you know if you got a reasonable answer?

% Define the observed data (RTs) and the model predictions based on the fitted parameters
model_predictions = arrayfun(@(rt) likelihood_function(fits, rt), RTs);

% 1. Visual Inspection: Plot the observed data and model predictions
figure;
subplot(2, 1, 1);
plot(RTs, 'b', 'DisplayName', 'Observed Data');
ylabel('RTs');
xlabel('Trial Number');
legend('Location', 'best');
title('Observed Data vs. Model Predictions');

subplot(2, 1, 2);
plot(model_predictions, 'r', 'DisplayName', 'Model Predictions');
ylabel('Probability');
xlabel('Trial Number');
legend('Location', 'best');

% 2. Goodness-of-Fit Metrics: Calculate and display goodness-of-fit metrics
residuals = RTs - model_predictions;
sse = sum(residuals.^2); % Sum of Squared Errors
n = length(RTs);
aic = n * log(sse/n) + 2 * 2; % Adjust for the number of parameters (2 in this case)
bic = n * log(sse/n) + 2 * 2 * log(n);

fprintf('Sum of Squared Errors (SSE): %.4f\n', sse);
fprintf('AIC: %.4f\n', aic);
fprintf('BIC: %.4f\n', bic);

% 3. Parameter Values: Examine the estimated parameter values
muR_estimate = fits(1);
deltaS_estimate = fits(2);

fprintf('Estimated muR: %.4f\n', muR_estimate);
fprintf('Estimated deltaS: %.4f\n', deltaS_estimate);


