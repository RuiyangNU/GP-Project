% Converts a decibel value to an amplitude for the computer's speakers.
% Not currently calibrated.
function amp = db2amp(dB)
    amp = 10^((dB/20)-6);
end