function vals = gradientCurve(inTest, outTest)
    noDupes = unique(inTest(:, 1));
    vals = zeros(1,2);
    
    for ii = 1:1:length(noDupes)
        indicies = find(inTest(:, 1) == noDupes(ii));
        [~, I] = min(abs(outTest(indicies.') - .5));
            vals(ii, :) = inTest(indicies(I), :);
    end
    
end
