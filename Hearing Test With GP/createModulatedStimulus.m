function modulatedStimulus = createModulatedStimulus(carrierF, modulationF, duration, samplerate, rampDuration)
    if ~exist('duration', 'var') || isempty(duration)
        duration = 1;
    end
    
    if ~exist('samplerate', 'var') || isempty(samplerate)
        samplerate = 44100;
    end

    if ~exist('rampDuration', 'var') || isempty(samplerate)
        rampDuration = .01;
    end
    
    maxPercent = zeros(1, (1 + duration) * samplerate);
    
    % 250ms - 500ms
    maxPercent(floor(0 * samplerate):floor(rampDuration * samplerate)) = ...
        linspace(0,1,floor(rampDuration * samplerate) - floor(0 * samplerate) + 1);
    
    % 500ms - end of stimulus
    maxPercent(floor(rampDuration * samplerate):floor(((duration - 4 * rampDuration) / 2)) * samplerate) = 1;
    
    % end of stimulus - end of stimulus + 250ms
    maxPercent(floor((duration - 4 * rampDuration) / 2 * samplerate):floor(duration / 2 * samplerate)) = ...
        linspace(1,0,floor(duration / 2 * samplerate) - floor(duration - 4 * rampDuration) + 1);
    
    