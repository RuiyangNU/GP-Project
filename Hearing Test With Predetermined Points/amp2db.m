% Converts an amplitude value for the computer's speakers to a decibel
% value.
% Not currently calibrated.
function dB = amp2db(amp)
    dB = 20*log10(amp/(10^-6));
end