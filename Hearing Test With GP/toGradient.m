function color = toGradient(y)
color = zeros([length(y) 3]);
for ii = 1:1:length(y)
    if y(ii) < 0
        color(ii,1) = 1;
        color(ii,2) = 0;
        color(ii,3) = 0;
    else
        color(ii,1) = 1-y(ii);
        color(ii,2) = y(ii);
        color(ii,3) = 0;
    end
end