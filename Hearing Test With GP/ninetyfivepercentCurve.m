function five, ninetyfive = confidenceCurve(inTest, outTest)
    noDupes = unique(inTest(:, 1));
    vals = zeros(1,2);
    
    for ii = 1:1:length(noDupes)
        indicies = find(inTest(:, 1) == noDupes(ii));
        for jj = 1:1:length(indicies)
            
            vals(ii, :) = inTest(indicies(I), :);
        end
    end
end
noDupes)