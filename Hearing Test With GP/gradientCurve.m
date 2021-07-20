function vals = gradientCurve(matrix)
    dimensions = size(matrix,1);
    vals = zeros(dimensions, 1);
    for ii = 1:1:dimensions
           vals(ii) = min(abs(matrix(:, ii) - .5));
    end
end