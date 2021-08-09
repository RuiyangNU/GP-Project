function audible = compareFFT(response)

    % Determine the length of the response to the signal
    L = length(response);
    
    % Break the response down into the response for the modulated signal
    % and the carrier signal
    modResponse = response(1:floor(L/2));
    carrResponse = response((floor(L/2)+1):end);
    
    % Run an FFT on either response
    modFFT = fft(modResponse);
    modL = length(modResponse);
    modP2 = abs(modFFT/modL);
    modP1 = modP2(1:modL/2+1);
    
    carrFFT = fft(carrResponse);
    carrL = length(carrResponse);
    carrP2 = abs(carrFFT/carrL);
    carrP1 = carrP2(1:carrL/2+1);
    
    % Compare the maxima of the two FFTs and determine whether the
    % modulated response was greater than the carrier response
    
    modMax = max(modP1);
    carrMax = max(carrP1);
    
    audible = modMax > 1.01 * carrMax;

end