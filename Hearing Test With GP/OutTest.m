%test output
clear;                                                                      %clears all varaibales from previuous run

mult=0.5;
f=50000;
t=2;
fs=96000;

d = daq('directsound');

ao = addoutput(d,"Audio1","1","Audio");
set(ao, 'SampleRate', fs);

ai = addinput(d,"Audio9","1","Audio");
set(ai, 'SampleRate', fs);

x=[1:t*fs];
y=sin((x/(fs/f))*(2*pi()));

yCh1_out=mult*y;
yCh2_out=mult*y;
xCh1_out=[1:length(y)]/fs;
% plot(yCh2_out);

data=[yCh1_out',yCh2_out'];
player=[ao ai];
putdata(ao, data);
start(player);
wait(ao, 20);


delete(ao);delete(ai);
clear ao; clear ai
% sound(y,Fs)