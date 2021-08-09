% returns a 1 or 0 based on the mouse's response to a
% modulated followed by a carrier frequency using fast fourier transform
function output = fftModulation(mouseResponse)
% splits the response into the modulated followed by the carrier frequency
    modulatedFreq = fft(mouseResponse(1:floor(length(mouseResponse)/2)));
    oneSidedModulated = modulatedFreq(1:length(modulatedFreq)/2+1)
    oneSidedModulated(2:end-1) = 2 * modulatedFreq(2:end-1)
    carrierFreq = fft(mouseResponse(floor(length(mouseResponse)/2)+1:end))
    oneSidedCarrier = carrierFreq(1:length(carrierFreq)/2+1)
    oneSidedCarrier(2:end-1) = 2 * carrierFreq(2:end-1)
    f1 = max(modulatedFreq);
    f2 = max(carrierFreq);
    if f1 > f2 * 1.01
        output = 1;
    else
        output = 0;
    end
    
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);