% Version 1.0
% Ray Tan, Jeffrey Tang
%
% Compares the response to the modulated signal (first half of response) to
% the response to the carrier signal (second half of response) and
% determines whether the modulated response is greater than the carrier
% response for a reason other than noise.
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
    
    carrFFT = fft(carrResponse);
    carrL = length(carrResponse);
    
    % Compute one-sided spetrum
    modP2 = abs(modFFT/modL);
    modP1 = modP2(1:ceil(modL/2)+1);

    carrP2 = abs(carrFFT/carrL);
    carrP1 = carrP2(1:ceil(carrL/2)+1);
    
    % Compare the maxima of the two FFTs and determine whether the
    % modulated response was greater than the carrier response
    
    modMax = max(modP1);
    carrMax = max(carrP1);
    
    audible = modMax > 1.01 * carrMax;

end