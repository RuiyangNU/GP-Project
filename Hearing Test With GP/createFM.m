% Version 1.0
% Ray Tan, Jeffrey Tang
%
% Creates an frequency modulated signal followed by a pure tone. The
% modulated signal has a frequency of freq, an amplitude of amp, and
% a modulation frequency of modfreq, with a modulation index of 1. The
% duration and samplerate of the signal are optional parameters with
% default values of 0.5 seconds and 44100 samples/second.

function stim = createFM(freq, modfreq, amp, duration, samplerate)
% set default values for duration and samplerate
    if ~exist('duration', 'var') || isempty(duration) 
        duration = 0.5;
    end
    
    if ~exist('samplerate', 'var') || isempty(samplerate)
        samplerate = 44100;
    end
    
    % Calculate the length of the signal in steps of 1/samplerate seconds
    signalLength = floor(0.06 * samplerate + 2 * duration * samplerate);
    
    %
    % Create Stimulus
    %
    
    % Create the upward/downward slope through limiting the max amplitude
    % at each time step.
    maxAmp = zeros(1, signalLength);
    
    % 0ms -> 10ms
    maxAmp(1:floor(0.01*samplerate)) = 0;
    
    % 10ms -> 20ms (Upward Slope)
    maxAmp(floor(0.01*samplerate):floor(0.02*samplerate)) = ...
        linspace(0,1,floor(0.02*samplerate)-floor(0.01*samplerate)+1);
    
    % 20ms -> end of stimulus (FM Tone)
    maxAmp(floor(0.02*samplerate):floor(0.02*samplerate + duration*samplerate)) = 1;
    
    % end of stimulus -> 10ms after (Downward Slope)
    maxAmp(floor(0.02*samplerate + duration*samplerate):floor(0.03*samplerate + duration*samplerate)) = ...
        linspace(1,0,floor(0.03*samplerate + duration*samplerate) - floor(0.02*samplerate + duration*samplerate) + 1);
    
    % end + 10ms -> end + 20ms
     maxAmp(floor(0.03*samplerate + duration*samplerate):floor(0.04*samplerate + duration*samplerate)) = ...
        0;
    
    % Copy the maximum amplitudes from the modulated section to the
    % non-modulated section
    maxAmp(floor(0.04*samplerate + duration*samplerate):end) = ...
        maxAmp(floor(0.01*samplerate):floor(0.03*samplerate + duration*samplerate));
    
    % Create array for stimulus
    stim = 1:1:signalLength;
    modIndex = zeros(1,signalLength);
    modIndex(1:floor(0.04*samplerate + duration*samplerate)) = 1;
    stim = maxAmp .* amp .* sin(2*pi* stim * freq/samplerate + modIndex .* sin(2*pi* stim * modfreq/samplerate));
end