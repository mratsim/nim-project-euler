# The following iterative sequence is defined for the set of positive integers:

# n → n/2 (n is even)
# n → 3n + 1 (n is odd)

# Using the rule above and starting with 13, we generate the following sequence:
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

# Which starting number, under one million, produces the longest chain?


import sequtils
from lib/integer_math import isEven

proc collatz(n: int): int =
  result = 1 # n

  var a = n

  while a != 1:
    if a.isEven:
      a = a shr 1
    else:
      a = 3*a + 1
    inc result
  inc result # Last item is 1

proc maxCollatz(a, b: int): int =
  if a.collatz >= b.collatz:
    return a
  return b

echo toSeq(2..1_000_000).foldl(maxCollatz(a,b), 1)

# TODO: use hashmap to cache/memoize the results