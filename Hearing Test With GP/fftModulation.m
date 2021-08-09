% returns a "hear" or "no hear" based on the mouse's response to a
% modulated followed by a carrier frequency using fast fourier transform
function output = fftModulation(mouseResponse)

    fourierResponse = fft(mouseResponse);
    
    % splits the response into the modulated followed by the carrier frequency
    f1 = max(fourierResponse(1:floor(length(mouseResponse)/2)));
    f2 = max(fourierResponse(floor(length(mouseResponse)/2)+1:end));
    
    if f1 > f2 * 1.01
        output = true;
    else
        output = false;
    end
    
end