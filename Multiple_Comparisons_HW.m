% Simulate t-tests with equal means and standard deviations
numTests = 1000;
alpha = 0.05;
p_values = nan(numTests, 1);
for i = 1:numTests
    sample1 = randn(100, 1); % Sample 1
    sample2 = randn(100, 1); % Sample 2
    [~, p] = ttest2(sample1, sample2);
    p_values(i) = p;
end

% Apply Benjamini-Hochberg correction
[~, bhq] = mafdr(p_values, 'BHFDR', true);

% Apply Bonferroni correction
bonferroni_alpha = alpha / numTests;
significant_bonferroni = p_values < bonferroni_alpha;

% Calculate the proportion of significant tests
prop_significant_benjamini = sum(bhq < alpha) / numTests;
prop_significant_bonferroni = sum(significant_bonferroni) / numTests;

fprintf('Proportion significant (Benjamini-Hochberg): %.4f\n', prop_significant_benjamini);
fprintf('Proportion significant (Bonferroni): %.4f\n', prop_significant_bonferroni);

% Set sample means with a difference of 1 and re-run the exercise
sample1 = randn(100, 1) + 1; % Sample 1 with mean 1
sample2 = randn(100, 1) + 2; % Sample 2 with mean 2

p_values_diff_means = nan(numTests, 1);
for i = 1:numTests
    [~, p] = ttest2(sample1, sample2);
    p_values_diff_means(i) = p;
end

% Apply Benjamini-Hochberg correction to the new p-values
[~, bhq_diff_means] = mafdr(p_values_diff_means, 'BHFDR', true);

% Apply Bonferroni correction to the new p-values
significant_bonferroni_diff_means = p_values_diff_means < bonferroni_alpha;

% Calculate the proportion of significant tests with different means
prop_significant_benjamini_diff_means = sum(bhq_diff_means < alpha) / numTests;
prop_significant_bonferroni_diff_means = sum(significant_bonferroni_diff_means) / numTests;

fprintf('Proportion significant (Benjamini-Hochberg, diff. means): %.4f\n', prop_significant_benjamini_diff_means);
fprintf('Proportion significant (Bonferroni, diff. means): %.4f\n', prop_significant_bonferroni_diff_means);
