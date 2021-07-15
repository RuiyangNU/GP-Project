%initializes the first x points with Halton Sampling (1964)
function initialValues = initialize(x)
haltonValues = haltonset(2, 1e3, 'Leap', 4)
initialValues = 60 * net(haltonValues, x)
end