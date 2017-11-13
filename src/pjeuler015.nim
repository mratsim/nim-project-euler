# Lattice paths:
# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.
# How many such routes are there through a 20×20 grid?

# Count of lattice paths from (0,0) to (n,k) with only 2 directions allowed
# is the binomial coef (n+k, n) i.e C(n+k, n) = (n+k)! / n!(n+k - n)!
# with a square grid k = n so C(2n, n) = (2n)! / n!n!

import lib/binomial

echo binomialCoeff(40,20)