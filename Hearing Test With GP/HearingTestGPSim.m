clear;
clc;

rng('default');
numIterations = 75;

% obtain reference curve
refSize = 100;
[refFreq, refAmp] = getRef(refSize);

% number of points on test scale
testSize = 200;

% in_observed = [13 20];
% in_observed = [in_observed(:,1), toHL(in_observed(:,1), in_observed(:,2))];
% out_observed = 1;

in_observed = initialize(5);
out_observed = zeros(5,1);
for ii = 1:1:5
    in_observed(ii,2) = toHL(in_observed(ii,1), in_observed(ii,2));
    
    freq = in_observed(ii,1);
    hl = in_observed(ii,2);
    hearing_loss = ReLU(freq - 15)^2;
    audible = double(hl - hearing_loss> 0);
    out_observed(ii,1) = audible;
end

freq_test = linspace(min(refFreq), max(refFreq), testSize)';
amp_test = linspace(-20, 80, testSize)';
[g1, g2] = meshgrid(freq_test, amp_test);
g1 = reshape(g1, [numel(g1),1]);
g2 = reshape(g2, [numel(g2),1]);
in_test = [g1, g2];

gprMdl = fitrgp(in_observed, out_observed, ...
        'KernelFunction', 'ardsquaredexponential', ...
        'FitMethod', 'sd', ...
        'BasisFunction', 'linear');
out_test = predict(gprMdl, in_test);

loss = zeros(1,numIterations);
loss(1) = resubLoss(gprMdl);

% gp

for ii = 2:1:numIterations
    
    % get frequency and HL of the most uncertain point
    [~, I] = min(abs(out_test - 0.55));
    freq = in_test(I, 1);
    hl = in_test(I, 2);
    
    % noise = 5 - (10 * rand());
    noise = 0;
    hl = hl + noise;
    
    % determine whether the given point is audible
    hearing_loss = ReLU(freq - 15)^2;
    noise = 5 - (10 * rand());
    audible = double(hl - hearing_loss + noise > 0);
    if rand() <= 0.00
        audible = double(~audible);
    end
    
    in_observed = [in_observed; freq, hl];
    out_observed = [out_observed; audible];
    
    gprMdl = fitrgp(in_observed, out_observed, ...
        'KernelFunction', 'ardsquaredexponential', ...
        'FitMethod', 'exact', ...
        'BasisFunction', 'linear');
    out_test = predict(gprMdl, in_test);
    
    out_observed_pred = predict(gprMdl, in_observed);
    out_observed_pred(out_observed_pred < 0) = 0;
    out_observed_pred(out_observed_pred > 1) = 1;
    loss(ii) = (out_observed-out_observed_pred)'* ...
        (out_observed-out_observed_pred)/numel(out_observed);
    
    averages = gradientCurve(in_test, out_test);

    % plotting
    subplot(2,1,1);
    scatter(in_test(:,1), in_test(:,2), 10, toGradient(out_test), 's', 'filled'); hold on;
    % plot(refFreq, toHL(refFreq, refAmp), 'Color', 'blue', 'LineWidth', 1);
    plot(averages(:,1), averages(:,2), 'Color', 'cyan', 'LineWidth', 1);
    scatter(in_observed(:,1), in_observed(:,2), 20, audib2color(out_observed), 'o', 'filled'); hold off;
    xlabel("frequency (bark)"); xlim([min(freq_test) max(freq_test)]);
    ylabel("dB SPL"); ylim([-20 80]);
    set(gca, 'YDir','reverse');
    
    subplot(2,1,2);
    plot(loss(1:ii));
    xlabel("iteration");
    ylabel("total loss");
    drawnow;
    
    pause();
    
%     if (ii > 35) && (loss(ii) < 0.05)
%         break;
%     end
end

% end
