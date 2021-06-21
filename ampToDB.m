function dB = ampToDB(amp)
    dB = 20*log10(amp/(10^-6));
end