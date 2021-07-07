clear;
clc;

rng('default');

in1_observed = linspace(1,10,5)';
in2_observed = linspace(1,10,5)';
x_observed = [reshape(repmat(in2_observed, 1, 5)', [numel(repmat(in2_observed, 1, 5)), 1]), repmat(in1_observed, 5, 1)];
%noise = rand(size(x_observed));

y_observed = double(x_observed(:,1) >= x_observed(:,2));

grp = fitrgp(x_observed, y_observed);

in1_test = linspace(1,10,10)';
in2_test = linspace(1,10,10)';
x_test = [reshape(repmat(in2_test, 1, 10)', [numel(repmat(in2_test, 1, 10)), 1]), repmat(in1_test, 10, 1)];

y_test = predict(grp, x_test);

scatter(x_test(:,1), x_test(:,2), 25, toGradient(y_test));