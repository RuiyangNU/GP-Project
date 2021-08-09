Fs = 44100;
S = createFM(440, 10, 1);
L = length(S);

Y = fft(S);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:L/2)/L;
plot(f(1:1000), P1(1:1000));