function modulatedStimulus = createModulatedStimulus(amplitude, duration, samplerate, carrierF, modulationF, rampDuration)
    carrierStimulus = createStimulus(carrierF, amplitude, duration, samplerate);
    modulatedStimulus = carrierStimulus(linspace(round(samplerate * rampDuration / duration), (end - round(samplerate * rampDuration / duration)), samplerate - 2*round(samplerate * rampDuration / duration))) * modulationF;
    