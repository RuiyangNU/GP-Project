x_in = [125, 250, 500, 750, 1000, 1500, 2000, 3000, 4000, 6000, ... 
        8000, 10000, 11200, 12500, 14000, 15000, 16000, 17000, 18000, ... 
        19000, 20000];
x_bark = hz2bark(x_in);
x = reshape(x_bark, [21, 1]);
y_in = [34.83, 25.40, 15.17, 11.67, 10.52, 14.96, 17.22, 15.24, ...
        12.67, 14.25, 16.35, 20.44, 22.99, 27.16, 33.43, 40.69, ...
        48.00, 64.70, 83.45, 93.81, 93.07];
y = reshape(y_in, [21, 1]);

gprMdl = fitrgp(x, y, 'Basis', 'linear','FitMethod', 'exact', 'PredictMethod', 'exact');
ypred = resubPredict(gprMdl);
plot(x,y,'b.');
hold on;
plot(x,ypred,'r','LineWidth',1.5);
xlabel('x');
ylabel('y');
legend('Data','GPR predictions');
hold off