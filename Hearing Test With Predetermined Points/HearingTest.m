% Version 1.0
% Ray Tan, Jeffrey Tang

% number of points along the frequency scale and the number of SPLs for
% each frequency
size = 3;

% generate reference curve
[refX, refY] = getRef();

% generate set of frequencies
freqs = linspace(min(refX), max(refX), size + 2);
freqs = freqs(2:end-1);

% generate set of spls to test for each frequency
spls = linspace(10, 50, size);

% generate set of points to test
[fgrid, splgrid] = meshgrid(freqs, spls);
freqs = reshape(fgrid, 1, size^2);
spls = reshape(splgrid, 1, size^2);


% generate a matrix to record values
audible = zeros(1,size^2);

for ii = 1:1:size
    % get the frequency and SPL for the current point
    freq = freqs(ii);
    spl = spls(ii);
    
    % create the stimulus
    stim = createStimulus(round(bark2hz(freq)), db2amp(spl));
    
    % show the current frequency and amplitude
    fprintf("frequency: %4.0fHz\namplitude: %0.3fdB\n", bark2hz(freq), spl);
    
    % play the stimulus
    sound(stim, 44100);
    % wait until sound is finished
    waitBox = msgbox('Please wait until the tone is finished playing.');
    uiwait(waitBox, 7);
    close(waitBox);
    
    % ask for feedback
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

audible = [-1 -1 1 -1 -1 1 -1 1 1];

% plot the graphs
% plot reference curve
subplot(2,2,[1,2]); plot(refX, refY);
title("Reference Hearing Thresholds");
xlabel("frequency (bark)");
ylabel("amplitude (dB SPL)");

% make a grid defining the color of each point
colors = audibToColor(audible);

% create scatter plot
subplot(2,2,3); scatter(freqs, spls, 15, colors);
hold on; plot(refX, refY); hold off;
title("Results in dB SPL");
xlabel("frequency (bark)");
ylabel("amplitude (dB SPL)");

% plot HL curve
hl = toHL(freqs, spls);
subplot(2,2,4); scatter(freqs, hl, 15, colors);
title("Results in HL");
xlabel("frequency (bark)");
ylabel("hearing loss");