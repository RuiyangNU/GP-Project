<<<<<<< Updated upstream
function output = hearOrNot(mouseResponse)
    fourierResponse = fft(mouseResponse)
    f1 = max(fourierResponse(1:floor(length(mouseResponse)/2)))
    f2 = max(fourierResponse(floor(length(mouseResponse)/2)+1:end))
    if f1 > f2 * 1.01;
        output = "hear"
=======
% returns a 1 or 0 based on the mouse's response to a
% modulated followed by a carrier frequency using fast fourier transform
function output = fftModulation(mouseResponse)
% splits the response into the modulated followed by the carrier frequency
    modulatedFreq = fft(mouseResponse(1:floor(length(mouseResponse)/2)));
    
    carrierFreq = fft(mouseResponse(floor(length(mouseResponse)/2)+1:end))

    f1 = max(modulatedFreq);
    f2 = max(carrierFreq);
    % checks if noise 
    if f1 > f2 * 1.01
        output = 1;
>>>>>>> Stashed changes
    else
        output = "no hear"
    
<<<<<<< Updated upstream
    end
=======
    % turns the two sided spectrum into one sided for easier code analysis
    % in the future, does not affect output
    oneSidedModulated = modulatedFreq(1:length(modulatedFreq)/2+1)
    oneSidedModulated(2:end-1) = 2 * modulatedFreq(2:end-1)
    % does the same thing to the carrier frequency as with the modulated
    oneSidedCarrier = carrierFreq(1:length(carrierFreq)/2+1)
    oneSidedCarrier(2:end-1) = 2 * carrierFreq(2:end-1)
    
>>>>>>> Stashed changes
