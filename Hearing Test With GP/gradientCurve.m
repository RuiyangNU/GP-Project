function vals = gradientCurve(matrix)
    dimensions = size(matrix,1);
    vals = zeros(dimensions, 1);
    [~,I] = min(matrix - .5);
    vals = I;
end
