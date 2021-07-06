% initializes the hearing level uncertainty curves
figure
x = linspace(hz2bark(125),hz2bark(20000), 1000);
y = 120*ones(size(x));
plot(x, y,'g')
hold on

y = zeros(size(x));
plot(x, y,'g')
hold on