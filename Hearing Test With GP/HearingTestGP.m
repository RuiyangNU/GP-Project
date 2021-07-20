% Version 1.0
% Ray Tan, Jeffrey Tang
%
% Conducts a hearing test with a set of predefined query points, and fits
% the results using a gaussian process regression to determine the
% remaining queries of the test. 

clear;
clc;

%
% Parameters
%

maxIterations = 50; % maximum number of queries before the program stops
targetLoss = 0.2; % finish testing when the target loss is achieved
maxAmplitude = 60; % maximum dB of tones delivered
numPredefinedPoints = 5; % number of points to test before using GP
referenceResolution = 100; % number of points along the reference scale
outputResolution = 100; % number of points along the frequency/amplitude
                        % axes predicted by the GP

%
% Initialization
%

observedInput = [];
observedOutput = [];
loss = zeros(1,maxIterations);

% Obtain reference curve
[refFreq, refdB] = getRef(referenceResolution);

% Generate points for prediction
testFreqs = linspace(min(refFreq), max(refFreq), outputResolution);
testAmps = linspace(-20, 80, outputResolution);
[g1, g2] = meshgrid(testFreqs, testAmps);
g1 = reshape(g1, [numel(g1),1]); g2 = reshape(g2, [numel(g2),1]);
testInput = [g1 g2];

% Predefined points for testing before using GP

predefinedValues = initialize(numPredefinedPoints);

% indices = round(linspace(1, referenceResolution, numPredefinedPoints + 2));
% predefinedFreqs = refFreq(indices(2:end-1));
% predefineddBs = refdB(indices(2:end-1));

%
% Conduct Hearing Test
%

% Predefined

for ii = 1:1:numPredefinedPoints
    % Load frequency and amplitude for test
    freqBark = predefinedValues(ii, 1);
    dB = predefinedValues(ii, 2);
    fprintf("Frequency: %0.0fHz\nAmp: %0.2fdB\n",bark2hz(freqBark),dB);
    
    % Update observed inputs
    observedInput = [observedInput; freqBark, toHL(freqBark, dB)];
    
    % Create stimulus
    stim = createStimulus(bark2hz(freqBark), db2amp(dB));
    
    % Deliver stimulus
    fprintf("Please wait until the tone is finished playing.\n");
    player = audioplayer(stim, 44100);
    play(player);
    
    % Ask for feedback
    while true
        result = input('Did you hear the tone? (y/n)','s');
        if result == 'y'
            observedOutput = [observedOutput; 1];
            break;
        elseif result == 'n'
            observedOutput = [observedOutput; 0];
            break;
        else
            msgbox('Please input a valid response.');
        end
    end
    
    % Graph results
    subplot(2,1,1);
    scatter(observedInput(:,1), observedInput(:,2), ...
        20, audib2color(observedOutput), 'o', 'filled'); % Observed In/Output
    xlim([min(refFreq), max(refFreq)]);
    ylim([-20, 80]);
    set(gca, 'YDir','reverse')
    drawnow;
end

% GP

for ii = numPredefinedPoints:1:maxIterations
    % Fit model
    gprMdl = fitrgp(observedInput, observedOutput, ...
        'KernelFunction', 'ardsquaredexponential', ...
        'FitMethod', 'exact', ...
        'BasisFunction', 'linear');
    testOutput = predict(gprMdl, testInput);
    loss(ii) = resubLoss(gprMdl);
    
    % get frequency and HL of the most uncertain point
    [~, I] = min(abs(testOutput - 0.5));
    freqBark = testInput(I, 1);
    hl = testInput(I, 2);
    fprintf("Frequency: %0.0fHz\nAmp: %0.2fdB\n",bark2hz(freqBark),toSpl(freqBark, hl));
    
    % Update observed inputs
    observedInput = [observedInput; freqBark, hl];
    
    % Create stimulus
    stim = createStimulus(bark2hz(freqBark), db2amp(toSpl(freqBark, hl)));
    
    % Deliver stimulus
    fprintf("Please wait until the tone is finished playing.\n");
    player = audioplayer(stim, 44100);
    play(player);
    
    % Ask for feedback
    while true
        result = input('Did you hear the tone? (y/n)','s');
        if result == 'y'
            observedOutput = [observedOutput; 1];
            break;
        elseif result == 'n'
            observedOutput = [observedOutput; 0];
            break;
        else
            msgbox('Please input a valid response.');
        end
    end
    
    % Graph results
    subplot(2,1,1);
    scatter(testInput(:,1), testInput(:,2), ...
        20, toGradient(testOutput), 's', 'filled'); hold on;
    scatter(observedInput(:,1), observedInput(:,2), ...
        20, audib2color(observedOutput), 'o', 'filled'); hold off; % Observed In/Output
    set(gca, 'YDir','reverse')
    xlim([min(refFreq), max(refFreq)]);
    ylim([-20, 80]);
    xlabel("Frequency (bark)");
    ylabel("HL (dB SPL)");
    
    subplot(2,1,2);
    plot(loss(numPredefinedPoints:ii));
    ylim([0;max(loss)+0.1]);
    xlabel("loss");
    drawnow;
end

fprintf("The test is finished.\n");