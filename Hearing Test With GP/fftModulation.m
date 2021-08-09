function output = hearOrNot(mouseResponse)
    fourierResponse = fft(mouseResponse)
    f1 = max(fourierResponse(1:floor(length(mouseResponse)/2)))
    f2 = max(fourierResponse(floor(length(mouseResponse)/2)+1:end))
    if f1 > f2 * 1.01;
        output = "hear"
    else
        output = "no hear"
    
    end