%{
% create a linear frequency scale
f = linspace(125, 20000, int16((20000-125)/10));

% convert linear scale to bark scale
b = bark(f);

% plot(b);
%}

xnorm = [125 250 500 1000 2000 4000 8000 16000 20000];
ynorm = [34.83 25.40 15.17 10.52 17.22 12.67 16.35 48.00 93.07];

xnew = bark(xnorm);
ynew = ynorm;

xnewb = linspace(xnew(1), xnew(length(xnew)), 100);
ynewb = interp1(xnew, ynew, xnewb);

plot(xnew, ynew, 'O', xnewb, ynewb);
%f = gca;
%f.XScale = 'log';



%{
% 
f0 = [];
L0 = [];

L = interp1(f0, L0, 1);

% plot data
plot(f0, L0, f, L);
%}