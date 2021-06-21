n = input('Number of data points: ');
dataArray = zeros([n 3]);

for i = 1:1:n
    % generate random frequency
    freq = (10^(1+3*rand))*2;
    dataArray(i,1) = freq;7
    disp(freq);
    
    % generate random amplitude between 20 and 80 dB
    amplitude = 10^(-2 - 5 * rand);
    dataArray(i,2) = amplitude;
    disp(amplitude);

    % playsound
    sound(createStimulus(freq,amplitude), 44100);
    % wait until sound is finished
    waitBox = msgbox('Please wait until the tone is finished playing.');
    uiwait(waitBox, 7);
    close(waitBox);
    
    % ask for feedback
    while true
        result = input('Did you hear the tone? (y/n)','s');
        if result == 'y'
            dataArray(i,3) = 1;
            break;
        elseif result == 'n'
            dataArray(i,3) = -1;
            break;
        else
            msgbox('Please input a valid response.');
        end
    end   
end

msgbox('The test is finished.');