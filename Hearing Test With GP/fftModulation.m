% returns a 1 or 0 based on the mouse's response to a
% modulated followed by a carrier frequency using fast fourier transform
function output = fftModulation(mouseResponse)
% splits the response into the modulated followed by the carrier frequency
    modulatedFreq = fft(mouseResponse(1:floor(length(mouseResponse)/2)));
    % turns the two sided spectrum into one sided for easier code analysis
    twoSidedModulated = abs(modulatedFreq/length(modulatedFreq));
    oneSidedModulated = twoSidedModulated(1:length(modulatedFreq)/2+1);
    oneSidedModulated(2:end-1) = 2 * oneSidedModulated(2:end-1);
    
    carrierFreq = fft(mouseResponse(floor(length(mouseResponse)/2)+1:end))
    twoSidedCarrier = abs(carrierFreq/length(carrierFreq));
    oneSidedCarrier = twoSidedCarrier(1:length(carrierFreq)/2+1);
    oneSidedCarrier(2:end-1) = 2 * oneSidedCarrier(2:end-1);

    f1 = max(modulatedFreq);
    f2 = max(carrierFreq);
    % checks if noise affects the result
    if f1 > f2 * 1.01
        output = 1;
    else
        output = 0;
    
    end
    
