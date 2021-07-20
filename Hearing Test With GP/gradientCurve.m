function vals = gradientCurve(matrix)
    dimensions = size(matrix,1);
    vals = zeros(dimensions, 1);
    [M,I] = min(matrix - .5)
    vals = I
end
