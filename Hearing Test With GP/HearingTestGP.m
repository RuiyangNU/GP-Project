clear;
clc;

% obtain reference curve
refSize = 100;
[refFreq, refAmp] = getRef(refSize);

% number of points on test scale
testSize = 200;

% create observed and test sets
index_observed = round(linspace(1,length(refFreq),10));
freq_observed = refFreq(index_observed);
amp_observed = 0:5:max(refAmp);
[g1, g2] = meshgrid(index_observed, amp_observed);
g1 = reshape(g1, [numel(g1),1]);
g2 = reshape(g2, [numel(g2),1]);

in_observed = [g1, g2];
out_observed = double(refAmp(in_observed(:,1))' <= in_observed(:,2));
in_observed(:,1) = refFreq(in_observed(:,1));

freq_test = linspace(min(refFreq), max(refFreq), testSize)';
amp_test = linspace(0, max(refAmp), testSize)';
[g1, g2] = meshgrid(freq_test, amp_test);
g1 = reshape(g1, [numel(g1),1]);
g2 = reshape(g2, [numel(g2),1]);
in_test = [g1, g2];

% gp
gprMdl = fitrgp(in_observed, out_observed, 'KernelFunction', 'ardsquaredexponential');
out_test = predict(gprMdl, in_test);

scatter(in_test(:,1), in_test(:,2), 200, toGradient(out_test), 's', 'filled'); hold on;
plot(refFreq, refAmp, 'Color', 'blue', 'LineWidth', 1);
scatter(in_observed(:,1), in_observed(:,2), 20, audib2color(out_observed), 'o'); hold off;
xlim([min(freq_test) max(freq_test)]);
ylim([0 max(amp_test)]);

% end
