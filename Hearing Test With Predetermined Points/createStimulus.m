% creates a stimulus with the given frequency and amplitude
function stimulusArray = createStimulus(freq, amplitude)
    % set default values for duration and samplerate
    duration = 3;
    samplerate = 44100;

    % create array with proper length
    stimulusArray = zeros((4 + duration) * samplerate, 1);

    % create sound wave using piecewise function
    for i = 1:1:length(stimulusArray)
        if i <= samplerate
            % keep zeros
            continue;
        elseif i > samplerate  && i <= 2 * samplerate
            % create upwards slope
            stimulusArray(i,1) = (mod(i, samplerate) / samplerate) * amplitude * sin(2 * pi * i * (freq / samplerate));
        elseif i > 2 * samplerate && length(stimulusArray) - i >= 2 * samplerate
            % create waves
            stimulusArray(i,1) = amplitude * sin(2 * pi * i * (freq / samplerate));
        elseif length(stimulusArray) - i < 2 * samplerate && length(stimulusArray) - i >= samplerate
            % create downwards slope
            stimulusArray(i,1) = ((samplerate - mod(i, samplerate)) / samplerate) * amplitude * sin(2 * pi * i * (freq / samplerate));
        else
            % keep zeros
            continue;
        end
    end
end

    
    
    