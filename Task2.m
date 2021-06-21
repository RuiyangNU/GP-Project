% edit properties of sound wave
duration = 3;
samplerate = 44100;

% generate a random frequecy between 20 and 20000 hz on a logarithmic
% scale.
freq = (10^(1+3*rand))*2;

% generate a random amplitude between 0 and 1.
amplitude = rand;

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

% display generated frequency and amplitude
disp(freq)
disp(amplitude)

sound(soundarr, samplerate)

clear
