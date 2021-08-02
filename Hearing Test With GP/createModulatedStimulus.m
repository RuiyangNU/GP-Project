function modulatedStimulus = createModulatedStimulus(carrierAmplitude, modulatedAmplitude, duration, samplerate, carrierF, modulationF, modulationDepth, rampDuration)
    modulatedStimulus = createStimulus(carrierF, carrierAmplitude, duration, samplerate) .* (1 + modulationDepth * createStimulus(modulationF, modulatedAmplitude, duration, samplerate));
    %%add ramps multiplication step here