% Version 1.0
% Ray Tan, Jeffrey Tang
% 
% Conducts a hearing test with a predetermined set of frequencies and
% intensities, and records the data as a SPL vs frequency curve and a HL
% curve.

%
% Parameters 
%

refSize = 100; % number of points on the reference scale
numFreqs = 5; % number of points along the frequency scale
numSPLs = 5; % number of points along to SPL scale
numPoints = numFreqs * numSPLs; % total number of test points

%
% Curve Generation
%

% generate reference (normal) dB SPL vs frequency curve
[refFreq, refSPL] = getRef();

% generate set of frequencies to test
stepSize = round(refSize/(numFreqs+1));
testFreq = stepSize:stepSize:numFreqs*stepSize;

% generate set of spls to test for each frequency
spls = linspace(10, 50, numSPLs);

% generate set of points to test
[fgrid, splgrid] = meshgrid(testFreq, spls);
testFreq = reshape(fgrid, 1, numPoints);
spls = reshape(splgrid, 1, numPoints);

% generate a matrix to record values
audible = zeros(size(testFreq));

%
% Conducting Test
%

for ii = 1:1:numPoints
    % get the frequency and SPL for the current point
    freq = testFreq(ii);
    spl = spls(ii);
    
    % create the stimulus
    stim = createStimulus(round(bark2hz(freq)), db2amp(spl));
    
    % show the current frequency and amplitude
    fprintf("frequency: %4.0fHz\namplitude: %0.3fdB\n", bark2hz(freq), spl);
    fprintf("Please listen for the tone.\n");
    
    % play the stimulus
    player = audioplayer(stim, 44100);
    play(player, 44100);
    
    % ask and record feedback
    while true
        result = input('Did you hear the tone? (y/n)','s');
        if result == 'y'
            audible(ii) = 1;
            break;
        elseif result == 'n'
            audible(ii) = -1;
            break;
        else
            msgbox('Please input a valid response.');
        end
    end
end

%
% Plotting Graphs
%

% plot reference curve
subplot(2,2,[1,2]); plot(refFreq, refSPL);
title("Reference Hearing Thresholds");
xlabel("frequency (bark)");
ylabel("amplitude (dB SPL)");

% plot dB SPL vs frequency curve
% make a grid defining the color of each point
colors = audib2color(audible);
% create scatter plot
subplot(2,2,3); scatter(testFreq, spls, 15, colors);
hold on; plot(refFreq, refSPL); hold off;
title("Results in dB SPL");
xlabel("frequency (bark)");
ylabel("amplitude (dB SPL)");

% plot HL curve
hl = toHL(testFreq, spls);
subplot(2,2,4); scatter(testFreq, hl, 15, colors);
title("Results in HL");
xlabel("frequency (bark)");
ylabel("hearing loss");