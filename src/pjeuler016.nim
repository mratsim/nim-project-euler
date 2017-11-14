# Power digit sum

# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

# What is the sum of the digits of the number 2^1000?

## Strategy:
# 2^1 = 2
# 2^2 = 2 + 2
# 2^3 = (2 + 2) + (2 + 2)

# i.e.: 2^n = 2^(n-1) + 2^(n-1)

import lib/digits
import sequtils

proc addArray[N: static[int]](a, b: array[N, int]): array[N, int] =
  # N: number of digits
  # Note: it will overflow if N is too small and last addition has a carry
  # Having that automatically grow with N+1 is easy here
  # but will make the proc hard to use in practice
  var i = 1
  var carry: int
  var sum: int

  while i <= N or carry > 0:
    if i <= N:
      sum = carry + a[^i] + b[^i]
      (result[^i], carry) = sum.divmod10
    else:
      (result[^i], carry) = carry.divmod10
    inc i

# let a = [4,5,2,1]
# echo addArray(a,a)
# echo 4521+4521

proc bigint_2pow1000: array[1000, int] =
  result[^1] = 2

  for e in 2..1000:
    result = addArray(result, result)


echo bigint_2pow1000().foldl(a + b)