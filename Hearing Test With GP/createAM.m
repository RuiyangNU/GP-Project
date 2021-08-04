function stim = createAM(freq, modfreq, modIndex, amp, duration, samplerate)
% set default values for duration and samplerate
    if ~exist('duration', 'var') || isempty(duration) 
        duration = 0.5;
    end
    
    if ~exist('samplerate', 'var') || isempty(samplerate)
        samplerate = 44100;
    end
    
    % Calculate the length of the signal in steps of 1/samplerate seconds
    signalLength = floor(0.05 * samplerate + 2 * duration * samplerate);
    
    %
    % Create Stimulus
    %
    
    % Create the upward/downward slope through limiting the max amplitude
    % at each time step.
    maxAmp = zeros(1, signalLength);
    
    % 0ms -> 10ms
    maxAmp(1:floor(0.01*samplerate)) = 0;
    
    % 10ms -> 20ms
    maxAmp(floor(0.01*samplerate):floor(0.02*samplerate)) = ...
        linspace(0,1,floor(0.02*samplerate)-floor(0.01*samplerate)+1);
    
    % 20ms -> end of stimulus
    maxAmp(floor(0.02*samplerate):floor(0.02*samplerate + duration*samplerate)) = 1;
    
    % end of stimulus -> 10ms after
    maxAmp(floor(0.02*samplerate + duration*samplerate):floor(0.03*samplerate + duration*samplerate)) = ...
        linspace(1,0,floor(0.03*samplerate + duration*samplerate) - floor(0.02*samplerate + duration*samplerate) + 1);
    
    % Copy the maximum amplitudes from the first ramp to the second
    maxAmp(floor(0.03*samplerate + duration*samplerate):end) = ...
        maxAmp(floor(0.01*samplerate):floor(0.03*samplerate + duration*samplerate));
    
    % Create array for stimulus
    stim = zeros(1, signalLength);
    for ii = 1:1:signalLength
        stim(ii) = maxAmp(ii) * (amp + modIndex * sin(2*pi*ii*modfreq/samplerate)) * sin(2*pi*ii*freq/samplerate);
    end
end