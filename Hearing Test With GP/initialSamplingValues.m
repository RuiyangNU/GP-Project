%initializes the first x points with Halton Sampling (1964)
function initialVals = initialize(x)
initialVals = zeros(x, 2);
haltonValues = haltonset(2, 1e3, 'Leap', 4);
vals = net(haltonValues, x);
initialAmp = 60 * vals(:,2);
initialFre = (hz2erb(125 + 15875 * vals(:,1);
initialVals(:, 1) = initialFre;
initialVals(:, 2) = initialAmp;
end