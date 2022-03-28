clear;

Fs=96000;
duration=1;

ai=analoginput('winsound',0);
addchannel(ai,1);
addchannel(ai,2);
set(ai, 'SampleRate', Fs);

requiredSamples = floor(Fs*duration);
ai.SamplesPerTrigger = requiredSamples;
waitTime = duration * 1.1 + 0.5;

player=[ai];
start(player);
wait(ai, waitTime);
[y, time] = getdata(ai);
plot(time,y(:,1),'-.');
xlabel('time (s)');
f0=gca;
    f0.XLim=[0 0.001];

delete(ai);
clear ai;