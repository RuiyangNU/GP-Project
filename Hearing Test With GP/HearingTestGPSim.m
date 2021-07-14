clear;
clc;

numIterations = 200;

% obtain reference curve
refSize = 100;
[refFreq, refAmp] = getRef(refSize);

% number of points on test scale
testSize = 200;

in_observed = [13 20];
in_observed = [in_observed(:,1), toHL(in_observed(:,1), in_observed(:,2))];
out_observed = 1;

freq_test = linspace(min(refFreq), max(refFreq), testSize)';
amp_test = linspace(-80, 20, testSize)';
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
    [~, I] = min(abs(out_test - 0.5));
    freq = in_test(I, 1);
    hl = in_test(I, 2);
    
    % determine whether the given point is audible
    noise = 5 - (10 * rand());
    audible = double(hl + noise > 0);
    
    in_observed = [in_observed; freq, hl];
    out_observed = [out_observed; audible];
    
    gprMdl = fitrgp(in_observed, out_observed, ...
        'KernelFunction', 'ardsquaredexponential', ...
        'FitMethod', 'exact', ...
        'BasisFunction', 'linear');
    out_test = predict(gprMdl, in_test);
    loss(ii) = resubLoss(gprMdl);

    % plotting
    subplot(2,1,1);
    scatter(in_test(:,1), in_test(:,2), 10, toGradient(out_test), 's', 'filled'); hold on;
    plot(refFreq, toHL(refFreq, refAmp), 'Color', 'blue', 'LineWidth', 1);
    scatter(in_observed(:,1), in_observed(:,2), 20, audib2color(out_observed), 'o', 'filled'); hold off;
    xlabel("frequency (Hz)"); xlim([min(freq_test) max(freq_test)]);
    ylabel("dB SPL"); ylim([-80 20]);
    
    subplot(2,1,2);
    plot(loss(1:ii));
    xlabel("iteration");
    ylabel("average loss");
    drawnow;
    
    if (ii > 35) && (loss(ii) < 0.05)
        break;
    end
end

% end
