%{
test = zeros([10000 1]);
for i = 1:1:length(test)
    test(i,1) = 100*sin(i/1500) + 20*rand();
end
%}

x = linspace(0,4*pi(),20);
y = [];

for i = 1:1:length(x)
    y(1,i) = sin(x(1,i))+(-1+2*rand());
end

mdl = fitrgp(x',y');

[yp,ys] = resubPredict(mdl);

subplot(2,1,1);plot(x,y,'O',x,yp);
subplot(2,1,2);plot(x,ys);

ylim([0 1]);

% plot(test);