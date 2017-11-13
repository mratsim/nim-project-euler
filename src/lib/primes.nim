# The MIT License (MIT)

# Copyright (c) 2016 Mamy Ratsimbazafy

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from math import `^`, gcd
from ./integer_math import isEven, divmod, isqrt
from ./functional import take, any
from ./bithacks import bit_length
from random import random
from future import `=>`
import ./modular_arithmetic


const lowPrimes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37] #, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997]

proc witnessCoPrime(witness, s, d, n: int): bool =
  var v = expmod(witness, d, n)
  if v == 1:
    return true
  for i in 0 .. s-2:
    if v == n - 1:
      return true
    v = expmod(v, 2, n)
  return v == n - 1


proc millerRabin(n: int): bool =
  ## Prime probablistic test, return True if probably prime

  # If n is composite then the Miller–Rabin primality test declares n probably prime with a probability at most 4−k
  # When the number n to be tested is small, trying all a < 2(ln n)2 is not necessary, as much smaller sets of potential witnesses are known to suffice. For example, Pomerance, Selfridge and Wagstaff[8] and Jaeschke[9] have verified that

  # if n < 2,047, it is enough to test a = 2;
  # if n < 1,373,653, it is enough to test a = 2 and 3;
  # if n < 9,080,191, it is enough to test a = 31 and 73;
  # if n < 25,326,001, it is enough to test a = 2, 3, and 5;
  # if n < 3,215,031,751, it is enough to test a = 2, 3, 5, and 7;
  # if n < 4,759,123,141, it is enough to test a = 2, 7, and 61;
  # if n < 1,122,004,669,633, it is enough to test a = 2, 13, 23, and 1662803;
  # if n < 2,152,302,898,747, it is enough to test a = 2, 3, 5, 7, and 11;
  # if n < 3,474,749,660,383, it is enough to test a = 2, 3, 5, 7, 11, and 13;
  # if n < 341,550,071,728,321, it is enough to test a = 2, 3, 5, 7, 11, 13, and 17.
  # Using the work of Feitsma and Galway enumerating all base 2 pseudoprimes in 2010, this was extended (see OEIS A014233), with the first result later shown using different methods in Jiang and Deng:[10]

  # if n < 3,825,123,056,546,413,051, it is enough to test a = 2, 3, 5, 7, 11, 13, 17, 19, and 23.
  # if n < 18,446,744,073,709,551,616 = 2^64, it is enough to test a = 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, and 37.
  # Sorenson and Webster[11] verify the above and calculate precise results for these larger than 64-bit results:

  # if n < 318,665,857,834,031,151,167,461, it is enough to test a = 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, and 37.
  # if n < 3,317,044,064,679,887,385,961,981, it is enough to test a = 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, and 41.

  # For n < 2^64, it is possible to perform strong-pseudoprime tests to the seven bases 2, 325, 9375, 28178, 450775, 9780504, and 1795265022 and completely determine the primality of n; see http://miller-rabin.appspot.com/.

  var d = n-1
  var s = 0
  while isEven d:
    d = d shr 1 # s div 2
    inc(s)

  for witness in lowPrimes.take(20):
    if not witnessCoPrime(witness, s, d, n):
      return false

  return true

proc isProbablyPrime*(n: int): bool =
  ## Probabilistic determination via Miller-Rabin test : 25 trials: 4^-25 probability of error

  if n < 2:
    return false #0, 1 and negative numbers are not prime

  # TODO only one pass

  # Check if it's on the prime list
  if any(lowPrimes, p => n == p):
    return true

  # check if one of those divides n
  if any(lowPrimes, p => n mod p == 0):
    return false

  # check if no divisor and n is smaller than p*p it's prime
  if any(lowPrimes, p => n < p * p):
    return true

  # check with Miller-Rabin
  return millerRabin(n)


# unfortunately Nim random function only accepts int for now instead of SomeInteger or SomeUnsignedInt for large numbers

############## Pollard Rho algorithm
proc pollard_f(x: int, c:int, n:int): int =
  ## pseudo random function (x2 + 1) mod n for Pollard Rho algo
  result = expmod(x,2,n)
  result = addmod(result, c, n)

proc pollardRho(n: int): int =
  if n.isEven(): return 2
  if n == 1: return 1

  # Check if it's on the prime list
  if any(lowPrimes, p => n == p):
    return n

  var x: int = random(n.int-3)+2 # from 2 to n-2
  var y: int = x
  var d: int = 1
  let c: int = random(n.int-1)+1 # from 1 to n-1

  while (d == 1):
    x = x.pollard_f(c,n)
    y = y.pollard_f(c,n).pollard_f(c,n)
    d = abs(x-y).gcd(n)

  if isProbablyPrime(d):
    return d
  return pollardRho(d) # if d = n retry with different random values


###### Pollard Rho retrieves 1 factor only, get the other
proc primFac_pollardRho*(n: int): seq[int] =
  if isProbablyPrime(n):
    return @[n]

  var x = n
  result = @[]

  while x > 1:
    let f = x.pollardRho()
    result.add(f)
    x = x div f

######
#Roll own bitvector for speed

type
  Base = seq[uint] #necessary to use the basic seq [] operator
  OddPackedBV = distinct Base

proc `[]`(b: OddPackedBV, i: uint): uint =
  Base(b)[cast[int](i shr 5)] shr (i and 31) and 1 # i and 31 is a fast way to do i mod 32

proc bv_composite_set(b: var OddPackedBV, i: uint) =
  var w = addr Base(b)[cast[int](i shr 5)]
  w[] = w[] or (1'u shl (i and 31)) # bit hack to set bit to 1

# Ideally we should implement items and pairs for proper iteration

#proc is faster than iterator
#to limit initialization time, primes will be with value 0 in the bit array
proc primeSieve*(n: uint): seq[uint] =
  result = @[]
  var a = newSeq[uint](n shr 6 + 1).OddPackedBV
  let maxn = (n - 1) shr 1 #TODO test boundaries
  let sqn = isqrt(n) shr 1 #TODO test boundaries
  for i in 1||sqn: #Use parallel OpenMP loops
    if a[i]==0:
      let prime = i shl 1 + 1
      for j in countup((prime*prime) shr 1, maxn, cast[int](prime)): #cross off multiples from i^2 to n, increment by i^2 + 2i because i^2+i is even
        a.bv_composite_set(j)
  result.add(2)
  for i in 1||maxn:
    if a[i]==0: result.add(i shl 1 + 1)