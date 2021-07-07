rng('default')

clear;
clc;

x_observed = linspace(0,10,20)';
noise = rand(size(x_observed)) * 0.5;

y_observed = sin(x_observed) + noise;

gpr = fitrgp(x_observed,y_observed,'KernelFunction','squaredexponential');

xtest = linspace(0,10,100)';

[ypredicted, ~, yint] = predict(gpr, xtest);

plot(xtest, ypredicted, 'Color', 'green');
hold on;
% plot(xtest, sin(xtest), 'Color', 'red');
scatter(x_observed, y_observed);
patch([xtest;flipud(xtest)],[yint(:,1);flipud(yint(:,2))],'k','FaceAlpha',0.1);
hold off;