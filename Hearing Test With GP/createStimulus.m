% Version 1.1
% Ray Tan, Jeffrey Tang
%
% function stimulusArray = createStimulus(freq, amplitude, duration, samplerate)
% double[] = double, double, double, int
%
% Creates a stimulus with the given frequency in Hz and amplitude. The duration
% and samplerate are optional parameters with default values of 0.5 seconds and
% 44100Hz, respectively.
%
function stimulus = createStimulus(freq, amplitude, duration, samplerate)
    % set default values for duration and samplerate
    if ~exist('duration', 'var') || isempty(duration) 
        duration = 0.5;
    end
    
    if ~exist('samplerate', 'var') || isempty(samplerate)
        samplerate = 44100;
    end

    % 
    % Create Stimulus
    %
    
    % define maximum percentage of amplitude for upward/downward slope
    maxPercent = zeros(1, (1 + duration) * samplerate);
    
    % 250ms - 500ms
    maxPercent(floor(0.25 * samplerate):floor(0.5 * samplerate)) = ...
        linspace(0,1,floor(0.5 * samplerate) - floor(0.25 * samplerate) + 1);
    
    % 500ms - end of stimulus
    maxPercent(floor(0.5 * samplerate):floor((0.5 + duration) * samplerate)) = 1;
    
    % end of stimulus - end of stimulus + 250ms
    maxPercent(floor((0.5 + duration) * samplerate):floor((0.75 + duration) * samplerate)) = ...
        linspace(1,0,floor((0.75 + duration) * samplerate) - floor((0.5 + duration) * samplerate) + 1);
    
    % create array for stimulus
    stimulus = zeros(1, (1 + duration) * samplerate);
    for ii = 1:1:length(stimulus)
        stimulus(ii) = maxPercent(ii) * amplitude * sin(2 * pi * ii * (freq / samplerate));
    end
end

    
    
    