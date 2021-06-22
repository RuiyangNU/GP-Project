n = input('Number of data points: ');
dataArray = zeros([n 3]);

for i = 1:1:n
    % generate random frequency on the bark scale between 125 and 20000 hz
    bfreq = bark(125)+(bark(20000)-bark(125))*rand;
    freq = invBark(bfreq);
    dataArray(i,1) = freq;
    disp(freq);
    
    % generate random amplitude between 20 and 80 dB
    dB = 20 + 60 * rand;
    amplitude = dBToAmp(dB);
    dataArray(i,2) = dB;
    disp(dB);

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