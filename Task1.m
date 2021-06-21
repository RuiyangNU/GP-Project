% edit properties of sound wave
duration = 3;
samplerate = 44100;
freq = 200;
amplitude = 1;

% create array with proper length
soundarr = zeros((4 + duration) * samplerate, 1);

% create sound wave using piecewise function
for i = 1:1:length(soundarr)
    if i <= samplerate
        % keep zeros
        continue;
    elseif i > samplerate  && i <= 2 * samplerate
        % create upwards slope
        soundarr(i,1) = (mod(i, samplerate) / samplerate) * amplitude * sin(2 * pi * i * (freq / samplerate));
    elseif i > 2 * samplerate && length(soundarr) - i >= 2 * samplerate
        % create waves
        soundarr(i,1) = amplitude * sin(2 * pi * i * (freq / samplerate));
    elseif length(soundarr) - i < 2 * samplerate && length(soundarr) - i >= samplerate
        % create downwards slope
        soundarr(i,1) = ((samplerate - mod(i, samplerate)) / samplerate) * amplitude * sin(2 * pi * i * (freq / samplerate));
    else
        % keep zeros
        continue;
    end
end

plot(soundarr)

xlim([84000 92000]);

% play sound
sound(soundarr, samplerate)

clear
