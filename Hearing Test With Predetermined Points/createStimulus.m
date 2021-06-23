% Version 1.0
% Ray Tan, Jeffrey Tang
%
% function stimulusArray = createStimulus(freq, amplitude, duration, samplerate)
%
% Creates a stimulus with the given frequency and amplitude. The duration
% and samplerate are optional parameters with default values of 3 and
% 44100, respectively.
%
function stimulusArray = createStimulus(freq, amplitude, duration, samplerate)
    % set default values for duration and samplerate
    if ~exist(duration, 'var') || isempty(duration) 
        duration = 3;
    end
    
    if ~exist(samplerate, 'var') || isempty(samplerate)
        samplerate = 44100;
    end

    % create array with proper length
    stimulusArray = zeros((4 + duration) * samplerate, 1);

    % create sound wave using piecewise function
    for i = 1:1:length(stimulusArray)
        if i <= samplerate
            % starting zeros
            continue;
        elseif i > samplerate  && i <= 2 * samplerate
            % create upward sloping sinusoid
            stimulusArray(i,1) = (mod(i, samplerate) / samplerate) * amplitude * sin(2 * pi * i * (freq / samplerate));
        elseif i > 2 * samplerate && length(stimulusArray) - i >= 2 * samplerate
            % create flat sinusoid with given amplitude
            stimulusArray(i,1) = amplitude * sin(2 * pi * i * (freq / samplerate));
        elseif length(stimulusArray) - i < 2 * samplerate && length(stimulusArray) - i >= samplerate
            % create downward sloping sinusoid
            stimulusArray(i,1) = ((samplerate - mod(i, samplerate)) / samplerate) * amplitude * sin(2 * pi * i * (freq / samplerate));
        else
            % stopping zeros
            continue;
        end
    end
end

    
    
    