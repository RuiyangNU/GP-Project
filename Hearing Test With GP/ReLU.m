function y = ReLU(x)
    y = x;
    y(y < 0) = 0;
end