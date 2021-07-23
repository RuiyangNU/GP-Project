function five, ninetyFive = confidenceCurve(inTest, outTest)
    noDupes = unique(inTest(:, 1));
    five = zeros(1,2);
    ninetyFive = zeros(1,2);
    
    for ii = 1:1:length(noDupes)
        indicies = find(inTest(:, 1) == noDupes(ii));
        for jj = length(indicies) * ii:-1:length(indicies) * (ii - 1) + 1
            if outTest(jj) - .95 <= 0
                ninetyFive(ii, :) = inTest(jj, :);
                break
            end
        end
        for kk = length(indicies) * (ii-1) + 1:1:length(indicies) * ii
            if outTest(kk) - .05 >= 0
                five(ii, :) = inTest(kk, :);
                break
            end
        end
    end
end